# alfresco-process-infrastructure

Helm chart to install the Alfresco Activiti Enterprise infrastructure including the Alfresco DBP infrastructure and the AAE platform level services to model and deploy AAE applications:

- PVC for storage
- Alfresco Identity Service (IDS)
- ACS (optional)
- Modeling Service
- Modeling App
- Deployment Service
- Admin App

Once installed, you can deploy new AAE applications:

* via the Admin App using the Deployment Service
* manually customising the [alfresco-process-application](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment) helm chart

*NB* at the moment only installation in the `default` namespace is supported.

## Prerequisites

### setup cluster

Setup a Kubernetes cluster using the guidelines in the [Alfresco DBP README](https://github.com/Alfresco/alfresco-dbp-deployment#alfresco-digital-business-platform-deployment).

### ingress

An ingress bound to an external DNS address, see `install-ingress.sh` for an example on AWS. 

### docker registry

A docker registry should be provided for the deployment service, see the `install-registry.sh` for an example on how to setup one on the same cluster on AWS.

### install helm

Install helm server on the cluster:

```bash
helm init --upgrade
```

then configure the required helm chart repositories:
```
helm repo add activiti-cloud-charts https://activiti.github.io/activiti-cloud-charts
helm repo add activiti-cloud-helm-charts https://activiti.github.io/activiti-cloud-helm-charts
helm repo add alfresco https://kubernetes-charts.alfresco.com/stable
helm repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
helm repo update
```

### helm tips

For any command on helm, please verify the output with `--dry-run` option, then execute without.

To install from the development chart repo, use `alfresco-incubator` rather than `alfresco` as **CHART_REPO** variable.

### kubectl tips

Check deployment progress with `kubectl get pods --watch` until all containers are running.
If anything is stuck check events with `kubectl get events --watch`.


### helm

Install helm.

*NB* if you plan on enabling the optional ACS, use helm 2.12.3  

### add quay-registry-secret

Configure access to pull images from quay.io in the installation namespace: 

```bash
kubectl create secret \
  docker-registry quay-registry-secret \
    --docker-server=quay.io \
    --docker-username="${DOCKER_REGISTRY_USER}" \
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
export HELM_OPTS="--debug
  --set global.gateway.http=${HTTP}
  --set global.gateway.domain=${DOMAIN}"
```

where:

* HTTP is true/false depending if you want external URLs using HTTP or HTTPS
* DOMAIN is your DNS domain

Follow [prerequisites](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#prerequisites) and [set variables as in process application chart README](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#set-environment-specific-variables)

### set secrets

Copy [secrets.yaml](helm/alfresco-process-infrastructure/secrets.yaml) to the root and customise its contents as in the comments and add to `HELM_OPTS`:

```bash
HELM_OPTS="${HELM_OPTS} -f secrets.yaml"
```

## with ACS (optional)


To include ACS in the infrastructure:

```bash
HELM_OPTS="
  ${HELM_OPTS}
  --set alfresco-content-services.enabled=true
  --set alfresco-content-services.alfresco-digital-workspace.enabled=true
  --set alfresco-deployment-service.alfresco-content-services.enabled=true
  --set alfresco-infrastructure.activemq.enabled=true
  --set nfs-server-provisioner.enabled=true
"
```

or just:
```bash
HELM_OPTS="${HELM_OPTS} -f alfresco-content-services.yaml"
```

### NFS Storage with ACS

In order to support multi-cloud NFS when ACS is enabled, [nfs-provisioner](https://github.com/kubernetes-incubator/external-storage/tree/master/nfs) is used.

### EFS Storage with ACS on AWS

As an AWS only alternative, you can use EFS as NFS. Make sure it is in the same VPC as your cluster and you open inbound traffic in the security group to allow NFS traffic.
Save the name of the server, for example:

    fs-647b1b84.efs.us-east-1.amazonaws.com

**NB** open the port for 'NFS' on default security group of VPC (i.e default - security group name) to '0.0.0.0/0 or your own subnet'

```bash
export NFS_SERVER="<dnsnameforEFS>"
# example: export NFS_SERVER=fs-647b1b84.efs.us-east-1.amazonaws.com
```
**NB** The Persistent Volume created to store the data on the created EFS has the ReclaimPolicy set to Recycle.
This means that by default, when you delete the release the saved data is deleted automatically.


Set variables as in [environment-setup](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#environment-setup) then run helm command to deploy chart with ACS:
```bash
helm install ./helm/alfresco-process-infrastructure \
  --namespace="${DESIRED_NAMESPACE}" \
  ${HELM_OPTS} \
  --set alfresco-infrastructure.persistence.enabled=true \
  --set alfresco-infrastructure.persistence.efs.enabled=true \
  --set alfresco-infrastructure.persistence.efs.dns="${NFS_SERVER}"
```

## launch helm

Set install parameters:

```bash
RELEASE_NAME=infrastructure
CHART_NAME=alfresco-process-infrastructure
```

then install from the stable repo using a released chart version:

```bash
helm upgrade --install \
  --repo https://kubernetes-charts.alfresco.com/stable \
  ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
```

or from the incubator repo a development chart version:

```bash
helm upgrade --install \
  --repo https://kubernetes-charts.alfresco.com/incubator \
  ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
```

or from the current repository directory:

```bash
helm repo update
helm dependency update helm/${CHART_NAME}
helm upgrade --install \
  ${HELM_OPTS} ${RELEASE_NAME} helm/${CHART_NAME}
```

## Extra Helm install scripts

Both support the following optional vars:

* RELEASE_NAME to handle upgrade or a non auto-generated release name
* HELM_OPTS to pass extra options to helm 

### install.sh

Just install/upgrade the APS2 infrastructure.

To verify the k8s yaml output:

```bash
HELM_OPTS="--debug --dry-run" ./install.sh
```

Verify the k8s yaml output than launch again without `--dry-run`.

### Docker for Desktop 


#### run in Docker for Desktop

A custom extra values file to add settings for _Docker for Desktop_ as specified in the [DBP README](https://github.com/Alfresco/alfresco-dbp-deployment#docker-for-desktop---mac) is provided:
```bash
HELM_OPTS="-f values-docker-for-desktop.yaml --wait" ./install.sh
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
export HELM_OPTS="${HELM_OPTS} -f values-registry.yaml"
```

### use an external PostgreSQL database

Modify the file values-external-postgresql.yaml providing values for your external database per each service, then run:

```bash
export HELM_OPTS="${HELM_OPTS} -f values-external-postgresql.yaml"
```

