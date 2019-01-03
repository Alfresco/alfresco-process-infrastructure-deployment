#!/usr/bin/env bash

APS_PROTOCOL=${APS_PROTOCOL:-http}
APS_HOST=${APS_HOST:-aps2mteodori.envalfresco.com}
EFS_HOST=${EFS_HOST:-fs-191c7853.efs.us-east-1.amazonaws.com}

cat << EOF > values.yaml
alfresco-content-services:
  externalProtocol: "${APS_PROTOCOL}"
  externalHost: "${APS_HOST}"
  repository:
    environment:
      IDENTITY_SERVICE_URI: "${APS_PROTOCOL}://${APS_HOST}/auth"
alfresco-infrastructure:
  nginx-ingress:
    enabled: false
EOF

if [[ -n "${EFS_HOST}" ]]
then
cat << EOF >> values.yaml
  persistence:
    efs:
      enabled: true
      dns: "${EFS_HOST}"
EOF
fi

HELM_OPTS="${HELM_OPTS} -f values.yaml" ./install.sh

rm values.yaml
