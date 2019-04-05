#!/usr/bin/env bash

PROTOCOL=${PROTOCOL:-http}
GATEWAY_HOST=${GATEWAY_HOST:-localhost}
SSO_HOST=${SSO_HOST:-${GATEWAY_HOST}}

cat << EOF > values.yaml
alfresco-content-services:
  externalProtocol: "${PROTOCOL}"
  externalHost: "${GATEWAY_HOST}"
  repository:
    environment:
      IDENTITY_SERVICE_URI: "${PROTOCOL}://${SSO_HOST}/auth"
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
