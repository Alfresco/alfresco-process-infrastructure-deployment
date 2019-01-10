# alfresco-process-infrastructure

This repository contains the helm chart with the infrastructure required by APS2, which includes the DBP one:

- PVC for storage
- Alfresco Identity Service
- ACS (APS 2.1 only, community which is the default choice or enterprise)

## install

Set variables as in [process application chart README](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#set-environment-specific-variables)

then [setup helm](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#install-helm)

### with ACS

To include ACS in the infrastructure set ACS chart name for community:

```bash
ACS_CHART_NAME=alfresco-content-services-community
```

then set helm parameters:
```bash
HELM_OPTS="
  ${HELM_OPTS}
  --set alfresco-content-services.externalProtocol=${PROTOCOL}
  --set alfresco-content-services.externalHost=${GATEWAY_HOST}
  --set alfresco-content-services.repository.environment.IDENTITY_SERVICE_URI=${SSO_URL}
"
```

and if you want to install ACS enterprise:
```bash
HELM_OPTS="
  ${HELM_OPTS}
  --set alfresco-content-services.enabled=true
"
```

or if you want to install ACS community:
```bash
HELM_OPTS="
  ${HELM_OPTS}
  --set alfresco-content-services-community.enabled=true
"
```

### launch helm

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
helm dependency update helm/${CHART_NAME}
helm upgrade --install \
  ${HELM_OPTS} ${RELEASE_NAME} helm/${CHART_NAME}
```

### EFS Storage with ACS on AWS

Create a EFS storage on AWS and make sure it is in the same VPC as your cluster. Make sure you open inbound traffic in the security group to allow NFS traffic.
Save the name of the server, for example:

    fs-647b1b84.efs.us-east-1.amazonaws.com

**NB** open the port for 'NFS' on default security group of VPC (i.e default - security group name) to '0.0.0.0/0 or your own subnet'

```bash
export NFS_SERVER="<dnsnameforEFS>"
# example: export NFS_SERVER=fs-647b1b84.efs.us-east-1.amazonaws.com
```
**NB** The Persistent Volume created to store the data on the created EFS has the ReclaimPolicy set to Recycle.
This means that by default, when you delete the release the saved data is deleted automatically.


Set variables as in [environment-setup](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#environment-setup) then run helm command to deploy chart with ACS (for _APS 2.1_):
```bash
helm install ./helm/alfresco-process-infrastructure \
  --namespace="${DESIRED_NAMESPACE}" \
  ${HELM_OPTS} \
  --set alfresco-infrastructure.persistence.enabled=true \
  --set alfresco-infrastructure.persistence.efs.enabled=true \
  --set alfresco-infrastructure.persistence.efs.dns="${NFS_SERVER}"
```

### Extra Helm install scripts

Both support the following optional vars:

* RELEASE_NAME to handle upgrade or a non auto-generated release name
* HELM_OPTS to pass extra options to helm 

#### install.sh

Just install/upgrade the APS2 infrastructure.

To verify the k8s yaml output:

```bash
HELM_OPTS="--debug --dry-run" ./install.sh
```

Verify the k8s yaml output than launch again without `--dry-run`.

#### install-ingress.sh

Just install/upgrade a separate ingress correctly configured for APS2 in order to avoid changing DNS entries for environment when upgrading the infrastructure.

### Docker for Desktop 


#### run in Docker for Desktop

A custom extra values file to add settings for _Docker for Desktop_ as specified in the [DBP README](https://github.com/Alfresco/alfresco-dbp-deployment#docker-for-desktop---mac) is provided:
```bash
HELM_OPTS="-f values-docker-for-desktop.yaml" ./install.sh
```
### override Docker images with internal Docker Registry

```bash

export APS_REGISTRY_HOST=internal.registry.io

make login

make values-registry.yaml

export HELM_OPTS="${HELM_OPTS} -f values-registry.yaml"
```