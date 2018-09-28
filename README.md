This reposity contains the helm chart with the infrastructure from DBP that is required by Process Services.
- identity
- gateway
- registry
- ACS


Helm command to deploy chart with ACS:

##### EFS Storage (NOTE! ONLY FOR AWS!)
Create a EFS storage on AWS and make sure it is in the same VPC as your cluster. Make sure you open inbound traffic in the security group to allow NFS traffic. Save the name of the server ex:

fs-6f1af576.efs.us-west-1.amazonaws.com

Imp note: open the port for 'NFS' on default security group of VPC (i.e default - security group name) to '0.0.0.0/0 or your own subnet' 
```bash
export NFSSERVER=<dnsnameforEFS>
example: export NFSSERVER=fs-6f1af576.efs.us-west-1.amazonaws.com
```
Note! The Persistent volume created to store the data on the created EFS has the ReclaimPolicy set to Recycle. This means that by default, when you delete the release the saved data is deleted automatically.



```helm install ./alfresco-process-services-infrastructure  --namespace=$DESIREDNAMESPACE --set alfresco-content-services.externalHost="$ELB_CNAME" --set alfresco-content-services.networkpolicysetting.enabled=false --set alfresco-content-services.repository.environment.IDENTITY_SERVICE_URI="http://$ELB_CNAME/auth" --set alfresco-infrastructure.alfresco-api-gateway.keycloakURL="http://$ELB_CNAME/auth/" --set alfresco-infrastructure.persistence.efs.enabled=true --set alfresco-infrastructure.persistence.efs.dns="$NFSSERVER"```