# alfresco-process-infrastructure

[![Build Status](https://travis-ci.com/Alfresco/alfresco-process-infrastructure-deployment.svg?branch=develop)](https://travis-ci.com/Alfresco/alfresco-process-infrastructure-deployment)

Helm chart to install the Alfresco Activiti Enterprise (AAE) infrastructure to model and deploy your process applications:

- PVC for storage
- Alfresco Identity Service
- ACS (optional)
- Modeling Service
- Modeling App
- Deployment Service (optional)
- Admin App

Once installed, you can deploy new AAE applications:

* via the _Admin App_ using the _Deployment Service_
* manually customising the [alfresco-process-application](https://github.com/Alfresco/alfresco-process-application-deployment) helm chart.

*NB* at the moment only installation in the `default` namespace is supported.

## Prerequisites

### setup cluster

Setup a Kubernetes cluster following your preferred procedure.

### install helm

Install helm.


If using helm 2, install helm server (tiller) on the cluster:
```bash
helm init --upgrade
```

If using the optional ACS skip API validation:

```bash
HELM_OPTS+=" --disable-openapi-validation"
```

Configure the required helm chart repositories:
```
helm repo add activiti https://activiti.github.io/activiti-cloud-helm-charts
helm repo add alfresco https://kubernetes-charts.alfresco.com/stable
helm repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
helm repo update
```

### ingress

An nginx-ingress bound to an external DNS address.

### docker registry

If the Deployment Service is installed, it requires in turn a Docker registry.
An external docker registry should be provided for the _AAE Deployment Service_.

### helm tips

For any command on helm, please verify the output with `--dry-run` option, then execute without.

To install from the development chart repo, use `alfresco-incubator` rather than `alfresco` as **CHART_REPO** variable.

### kubectl tips

Check deployment progress with `kubectl get pods --watch` until all containers are running.
If anything is stuck check events with `kubectl get events --watch`.


### add quay-registry-secret

Configure access to pull images from quay.io in the installation namespace: 

```bash
kubectl create secret \
  docker-registry quay-registry-secret \
    --docker-server=quay.io \
    --docker-username="${DOCKER_REGISTRY_USERNAME}" \
    --docker-password="${DOCKER_REGISTRY_PASSWORD}" \
    --docker-email="none"
```

### add license secret

Create a secret called _licenseaps_ containing the license file in the installation namespace.

```bash
kubectl create secret \
  generic licenseaps --from-file activiti.lic
```

### set main helm env variables

```bash
export DESIRED_NAMESPACE=${DESIRED_NAMESPACE:-default}
export HELM_OPTS+=" --debug \
  --namespace $DESIRED_NAMESPACE \
  --set global.gateway.http=${HTTP} \
  --set global.gateway.domain=${DOMAIN}"
```

where:

* HTTP is true/false depending if you want external URLs using HTTP or HTTPS
* DOMAIN is your DNS domain
* DESIRED_NAMESPACE is the installation namespace, at the moment only "default" namespace is supported


### set environment specific variables

#### for Docker Desktop

```bash
export PROTOCOL=http
export GATEWAY_HOST=kubernetes.docker.internal 
export SSO_HOST=$GATEWAY_HOST
```

#### for AAE dev example environment

```bash
export ENVIRONMENT=aaedev
export PROTOCOL=https
export DOMAIN=${CLUSTER}.envalfresco.com
export GATEWAY_HOST=${GATEWAY_HOST:-gateway.${DOMAIN}}
export SSO_HOST=${SSO_HOST:-identity.${DOMAIN}}
```

### set helm env variables

```bash
export HTTP=$(if [[ "${PROTOCOL}" == 'http' ]]; then echo true; else echo false; fi)
HELM_OPTS+=" --set global.gateway.http=$HTTP \
  --set global.gateway.host=$GATEWAY_HOST \
  --set global.keycloak.host=$SSO_HOST"
```

### set secrets (for deployment service only)

Copy [secrets.yaml](helm/alfresco-process-infrastructure/secrets.yaml) to the root and customise its contents as in the comments and add to `HELM_OPTS`:

```bash
HELM_OPTS+=" -f secrets.yaml"
```

## with ACS (optional)

To include ACS in the infrastructure:

```bash
HELM_OPTS+=" \
  --set alfresco-content-services.enabled=true \
  --set alfresco-deployment-service.alfresco-content-services.enabled=true"
```

or just:
```bash
HELM_OPTS+=" -f values-alfresco-content-services.yaml"
```

## disable alfresco-deployment-service

To disable alfresco-deployment-service in the infrastructure:

```bash
HELM_OPTS+=" \
  --set alfresco-deployment-service.enabled=false"
  --set alfresco-deployment-service.postgres.enabled=false"
```


## File Storage

### NFS Storage

In order to support NFS in any cloud, install [nfs-server-provisioner](https://github.com/helm/charts/tree/master/stable/nfs-server-provisioner).

```bash
helm install stable/nfs-server-provisioner \
  --set persistence.storageClass=standard \
  --set storageClass.name=${DESIRED_NAMESPACE}-sc \
  --namespace $DESIRED_NAMESPACE
```

### EFS Storage

Create an EFS storage on AWS in the same VPC as your cluster with NFS open inbound traffic in the nodes security group and store the name in `NFS_SERVER`. 

Install the [nfs-client-provisioner](https://github.com/helm/charts/tree/master/stable/nfs-client-provisioner):

```bash
helm install stable/nfs-client-provisioner \
  --set nfs.server=$NFS_SERVER \
  --set nfs.path=/ \
  --set storageClass.name=${DESIRED_NAMESPACE}-sc \
  --namespace $DESIRED_NAMESPACE
```

***NB***
The Persistent volume created with NFS to store the data has the [ReclaimPolicy](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy) set by default to Delete.
This means that by default, when you delete the release the saved data is deleted automatically.
To change this behaviour and keep the data you can set the `storageClass.reclaimPolicy` value to `Retain`.

Add the helm properties to use it:

```bash
HELM_OPTS+="
  --set persistence.storageClassName=${DESIRED_NAMESPACE}-sc
  --set alfresco-content-services.alfresco-infrastructure.persistence.storageClass.enabled=true \
  --set alfresco-content-services.alfresco-infrastructure.persistence.storageClass.name=${DESIRED_NAMESPACE}-sc \
  --set alfresco-deployment-service.connectorVolume.storageClass=${DESIRED_NAMESPACE}-sc \
  --set alfresco-deployment-service.connectorVolume.permission=ReadWriteMany 
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
RELEASE_NAME=aae-infrastructure
CHART_NAME=alfresco-process-infrastructure
```

then install from the stable repo using a released chart version:

```bash
helm upgrade --install \
  --repo https://kubernetes-charts.alfresco.com/stable \
  $HELM_OPTS $RELEASE_NAME helm/$CHART_NAME
```

or from the incubator repo a development chart version:

```bash
helm upgrade --install \
  --repo https://kubernetes-charts.alfresco.com/incubator \
  $HELM_OPTS $RELEASE_NAME helm/$CHART_NAME
```

or from the current repository directory:

```bash
helm repo update
helm dependency update helm/${CHART_NAME}
helm upgrade --install \
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

### run in Docker Desktop

A custom extra values file to add settings for _Docker Desktop_ is provided:
```bash
HELM_OPTS+=" -f values-docker-desktop.yaml" ./install.sh
```
*NB* with ACS enabled the startup might take as much as 10 minutes, use ```kubectl get pods --watch``` to check the status.

## Testing

### Access IDS

Open browser and login to IDS:
```bash
open ${SSO_URL}
```

### Verify Realm

To read back the realm from the secret, use:
```bash
kubectl get secret realm-secret -o jsonpath="{['data']['alfresco-aps-realm\.json']}" | base64 -D > alfresco-aps-realm.json
```

### override Docker images with internal Docker Registry

Upload images to your internal registry and generate a values file with the new image locations for helm with:

```bash
export REGISTRY_HOST=internal.registry.io
make login
make values-registry.yaml
export HELM_OPTS+=" -f values-registry.yaml"
```

### use an external PostgreSQL database

Modify the file values-external-postgresql.yaml providing values for your external database per each service, then run:

```bash
export HELM_OPTS+=" -f values-external-postgresql.yaml"
```

## CI/CD

Running on Travis, requires the following environment variable to be set:

| Name | Description |
|------|-------------|
| GITHUB_TOKEN | GitHub token to clone/push helm repo |
