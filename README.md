# alfresco-process-infrastructure

[![Build Status](https://travis-ci.com/Alfresco/alfresco-process-infrastructure-deployment.svg?branch=develop)](https://travis-ci.com/Alfresco/alfresco-process-infrastructure-deployment)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Helm chart to install the Alfresco Activiti Enterprise (AAE) infrastructure to model and deploy your process applications:

- Alfresco Identity Service
- Modeling Service
- Modeling App
- Deployment Service
- Admin App
- Transformation (Tika) Service

Once installed, you can deploy new AAE applications:

* via the _Admin App_ using the _Deployment Service_
* manually customising the [alfresco-process-application](https://github.com/Alfresco/alfresco-process-application-deployment) helm chart.

For all the available values, see the chart [README.md](helm/alfresco-process-infrastructure/README.md#values).

## Prerequisites

### setup cluster

Setup a Kubernetes cluster following your preferred procedure.

### install helm

Install the latest version of helm.

### ingress

An `ingress-nginx` should be installed and bound to an external DNS address, for example:

```
helm upgrade --install --wait --repo https://kubernetes.github.io/ingress-nginx ingress-nginx ingress-nginx
```

### helm tips

For any command on helm, please verify the output with `--dry-run` option, then execute without.

To install from the development chart repo, use `alfresco-incubator` rather than `alfresco` as **CHART_REPO** variable.

### kubectl tips

Check deployment progress with `kubectl get pods --watch --all-namespaces` until all containers are running.
If anything is stuck, check events with `kubectl get events --watch`.


### configure installation namespace

```bash
export DESIRED_NAMESPACE=${DESIRED_NAMESPACE:-aae}
```

### add quay-registry-secret

Configure access to pull images from quay.io in the installation namespace:

```bash
kubectl create secret \
  --namespace $DESIRED_NAMESPACE \
  docker-registry quay-registry-secret \
    --docker-server=quay.io \
    --docker-username=$QUAY_USERNAME \
    --docker-password=$QUAY_PASSWORD
```

where:

* _QUAY_USERNAME_ is your username on Quay
* _QUAY_PASSWORD_ is your password on Quay

### set main helm env variables

```bash
export HELM_OPTS+=" --debug \
  --namespace $DESIRED_NAMESPACE \
  --set global.gateway.http=$HTTP \
  --set global.gateway.domain=$DOMAIN"
```

where:

* _HTTP_ is true/false depending if you want external URLs using HTTP or HTTPS
* _DOMAIN_ is your DNS domain


### set environment specific variables

#### for localhost

```bash
export PROTOCOL=http
export DOMAIN=host.docker.internal
```

*NB* add to your `/etc/hosts` the line `127.0.0.1 host.docker.internal` if not present

#### for a cloud environment

```bash
export CLUSTER=aaedev
export PROTOCOL=https
export DOMAIN=$CLUSTER.envalfresco.com
```

#### set generated variables

```bash
export GATEWAY_HOST=$DOMAIN
export SSO_HOST=$DOMAIN
```

### set helm env variables

```bash
export HTTP=$(if [[ "$PROTOCOL" == 'http' ]]; then echo true; else echo false; fi)
HELM_OPTS+=" --set global.gateway.http=$HTTP \
  --set global.gateway.domain=$DOMAIN"
```

### disable alfresco-deployment-service

To disable alfresco-deployment-service in the infrastructure:

```bash
HELM_OPTS+="
  --set alfresco-deployment-service.enabled=false
"
```

## Multi-AZ K8S cloud StorageClass for project release

A StorageClass that can work across multiple availability zones need to be available to store project release files per each application:
* for EKS always use EFS
* for AKS only if Multi-AZ is configured, use AFS

Add the helm values to use it:

```bash
HELM_OPTS+="
  --set alfresco-deployment-service.projectReleaseVolume.storageClass=${STORAGE_CLASS_NAME} \
  --set alfresco-deployment-service.projectReleaseVolume.permission=ReadWriteMany
"
```

### Email Connector

***NB***
In order to set email connector all the variables need to be set. If these variables are set then deployment service will use these configs as default for any applications deployed. Once these variables are configured at the deployment of chart via Helm customer won’t have the possibility to override these values from the admin app. In case you want to configure email connector variable from admin-app please dont not configure email connector during helm deployment.

Add the helm properties to configure email connector:

```bash
HELM_OPTS+="
  --set alfresco-deployment-service.applications.connectors.emailConnector.username=${email_connecor_username}
  --set alfresco-deployment-service.applications.connectors.emailConnector.password=${email_connector_password}
  --set alfresco-deployment-service.applications.connectors.emailConnector.host=${email_connector_host}
  --set alfresco-deployment-service.applications.connectors.emailConnector.port=${email_connector_port}
"
```

## launch helm

Set install parameters:

```bash
export RELEASE_NAME=aae
export CHART_NAME=alfresco-process-infrastructure
```

then install from the stable repo using a released chart version:

```bash
helm upgrade --install --wait \
  --repo https://kubernetes-charts.alfresco.com/stable \
  $HELM_OPTS $RELEASE_NAME $CHART_NAME
```

or from the incubator repo a development chart version:

```bash
helm upgrade --install --wait \
  --namespace $DESIRED_NAMESPACE \
  --repo https://kubernetes-charts.alfresco.com/incubator \
  $HELM_OPTS $RELEASE_NAME $CHART_NAME
```

or from the current repository directory:

```bash
helm repo update
helm dependency update helm/${CHART_NAME}
helm upgrade --install --wait \
  --namespace $DESIRED_NAMESPACE \
  $HELM_OPTS $RELEASE_NAME helm/$CHART_NAME
```

## Extra Helm install scripts

Both support the following optional vars:

* RELEASE_NAME to handle upgrade or a non auto-generated release name
* HELM_OPTS to pass extra options to helm

### install.sh

Just install/upgrade the AAE infrastructure.

To verify the k8s yaml output:

```bash
HELM_OPTS+="--debug --dry-run" ./install.sh
```

Verify the k8s yaml output than launch again without `--dry-run`.

### run on localhost

A custom extra values file to add settings for _localhost_ is provided:
```bash
HELM_OPTS+=" -f values-localhost.yaml" ./install.sh
```
*NB* the startup might take as much as 10 minutes, use ```kubectl get pods -A -w``` to check the status.

## Testing

### Access IDS

Open browser and login to IDS:
```bash
open ${SSO_URL}
```

### Verify Realm

To read back the realm from the secret, use:
```bash
kubectl get secret \
  --namespace $DESIRED_NAMESPACE \
  realm-secret -o jsonpath="{['data']['alfresco-realm\.json']}" | base64 -D > alfresco-realm.json
```

### Use an internal Docker Registry

In an [air gapped](https://en.wikipedia.org/wiki/Air_gap_(networking)) environment where the Kubernetes cluster has no direct access to external image repositories, use a tool like [helm-image-mirror](https://github.com/shashankv02/helm-image-mirror) to tag and push images to your internal registry and modify helm charts with the new image locations.


### Use an external PostgreSQL database

Modify the file values-external-postgresql.yaml providing values for your external database per each service, then run:

```bash
export HELM_OPTS+=" -f values-external-postgresql.yaml"
```

## CI/CD

Running on GH Actions.

For Dependabot PRs to be validated by CI, the label "CI" should be added to the PR.

Requires the following secrets to be set:

| Name                          | Description                          |
|-------------------------------|--------------------------------------|
| BOT_GITHUB_TOKEN              | Token to launch other builds on GH   |
| BOT_GITHUB_USERNAME           | Username to issue propagation PRs    |
| RANCHER2_URL                  | Rancher URL to perform helm tests    |
| RANCHER2_ACCESS_KEY           | Rancher access key                   |
| RANCHER2_SECRET_KEY           | Rancher secret key                   |
| SLACK_NOTIFICATION_BOT_TOKEN  | Token to notify slack on failure     |
