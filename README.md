# alfresco-process-infrastructure

This repository contains the helm chart with the infrastructure required by APS2, which includes the DBP one:

- PVC for storage
- Alfresco Identity Service
- ACS (optional)

## install

Follow [prerequisites](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#prerequisites) and [set variables as in process application chart README](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#set-environment-specific-variables)

then [setup helm](https://git.alfresco.com/process-services-public/alfresco-process-application-deployment#install-helm)

### set secrets

Copy [secrets.yaml](helm/alfresco-process-infrastructure/secrets.yaml) to the root and customise its contents as in the comments and add to _HELM_OPTS_:

```bash
HELM_OPTS="${HELM_OPTS} -f secrets.yaml"
```

### with ACS (optional)

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
HELM_OPTS="${HELM_OPTS} -f secrets.yaml"
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
helm repo update
helm dependency update helm/${CHART_NAME}
helm upgrade --install \
  ${HELM_OPTS} ${RELEASE_NAME} helm/${CHART_NAME}
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
HELM_OPTS="-f values-docker-for-desktop.yaml --wait" ./install.sh
```
*NB* with ACS enabled the startup might take as much as 10 minutes, use ```kubectl get pods --watch``` to check the status.

## Testing

### Access AIS

Open browser and login to AIS:
```bash
open ${SSO_URL}
```

### Verify Realm

To read back the realm from the secret, use:
```bash
kubectl get secret realm-secret -o jsonpath="{['data']['alfresco-aps-realm\.json']}" | base64 -D > alfresco-aps-realm.json
```

### override Docker images with internal Docker Registry

Upload images to your internal registry using the [upload_images.sh](helm/alfresco-process-infrastructure/upload_images.sh) with the followinf variables:
* QUAY_USER
* QUAY_PASSWORD
* REGISTRY_HOST
* REGISTRY_USER
* REGISTRY_PASSWORD

then update the values before installing to reference the new location for images on your internal registry:

```bash
export APS_REGISTRY_HOST=internal.registry.io
make login
make values-registry.yaml
export HELM_OPTS="${HELM_OPTS} -f values-registry.yaml"
```
