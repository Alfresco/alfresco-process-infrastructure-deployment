# alfresco-process-infrastructure

This repository contains the helm chart with the DBP infrastructure that is required by APS2:

- identity
- ACS

#### EFS Storage (NOTE! ONLY FOR AWS!)

Create a EFS storage on AWS and make sure it is in the same VPC as your cluster. Make sure you open inbound traffic in the security group to allow NFS traffic. Save the name of the server ex:

    fs-6f1af576.efs.us-west-1.amazonaws.com

**NB** open the port for 'NFS' on default security group of VPC (i.e default - security group name) to '0.0.0.0/0 or your own subnet'

```bash
export NFSSERVER=<dnsnameforEFS>
example: export NFSSERVER=fs-6f1af576.efs.us-west-1.amazonaws.com
```
Note! The Persistent volume created to store the data on the created EFS has the ReclaimPolicy set to Recycle. This means that by default, when you delete the release the saved data is deleted automatically.

Helm command to deploy chart with ACS:

    helm install ./helm/alfresco-process-infrastructure \
      --namespace=$DESIREDNAMESPACE \
      --set alfresco-content-services.externalHost="$ELB_CNAME" \
      --set alfresco-content-services.repository.environment.IDENTITY_SERVICE_URI="http://$ELB_CNAME/auth" \
      --set alfresco-infrastructure.persistence.efs.enabled=true \
      --set alfresco-infrastructure.persistence.efs.dns="$NFSSERVER"

A custom extra values file to add settings for _Docker for Desktop_ is provided: `-f docker-for-desktop-values.yaml`

### Extra Helm install scripts

Both support the following optional vars:

* RELEASE_NAME to handle upgrade or a non auto-generated release name
* HELM_OPTS to pass extra options to helm 

#### install.sh

Just install/upgrade the APS2 infrastructure.

To verify the k8s yaml output:

    HELM_OPTS="--debug --dry-run" ./install.sh

To install just alfresco-identity-service with the APS2 realm:

    HELM_OPTS="
      --debug
      --dry-run
      --set alfresco-infrastructure.nginx-ingress.enabled=false
      --set alfresco-content-services.enabled=false
      --set alfresco-infrastructure.persistence.enabled=false
    " ./install.sh

Verify the k8s yaml output than launch again without `--dry-run`.

#### install-ingress.sh

Just install/upgrade a separate ingress correctly configured for APS2.

Supports an options HELM_OPTS variable, for example to install without ingress:

    HELM_OPTS="--set alfresco-infrastructure.nginx-ingress.enabled=false" ./install.sh

A custom extra values file to add settings for _Docker for Desktop_ as specified in the [DBP README](https://github.com/Alfresco/alfresco-dbp-deployment#docker-for-desktop---mac) is provided:

    HELM_OPTS="-f docker-for-desktop-values.yaml" ./install.sh
