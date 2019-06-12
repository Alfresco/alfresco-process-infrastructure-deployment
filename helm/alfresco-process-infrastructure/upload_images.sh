#!/usr/bin/env bash

QUAY_HOST=${QUAY_HOST:-quay.io}
echo uploading to ${REGISTRY_HOST}

# 5 min timeout
REGISTRY_URL="https://${REGISTRY_HOST}"
echo "connecting to ${REGISTRY_URL}"
COUNTER=0

while [[ $COUNTER -lt 300 && "$(curl -s -o /dev/null -w '%{http_code}' ${REGISTRY_URL}/)" != "200" ]]
do
  echo "."
  sleep 5
  let COUNTER=COUNTER+1
done
echo "connection OK"

if [[ -n "${REGISTRY_USER}" ]]
then
  echo using user ${REGISTRY_USER}
  docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY_HOST}
fi
docker login -u ${QUAY_USER} -p ${QUAY_PASSWORD} ${QUAY_HOST}

IMAGES="
  alfresco/alfresco-process-query-service:2.1.0
  alfresco/alfresco-process-audit-service:2.1.0
  alfresco/alfresco-process-storage-service:2.1.0
  alfresco/alfresco-process-notifications-graphql-service:2.1.0
  alfresco/alfresco-process-workspace-app:2.1.0
  alfresco/alfresco-process-camel-connector-service:2.1.0
  alfresco/alfresco-process-email-connector-service:2.1.0
  alfresco/alfresco-process-lambda-connector-service:2.1.0
  alfresco/alfresco-process-rest-connector-service:2.1.0
  alfresco/alfresco-process-salesforce-connector-service:2.1.0
  alfresco/alfresco-process-slack-connector-service:2.1.0
  alfresco/alfresco-process-twilio-connector-service:2.1.0
  alfresco/alfresco-digital-workspace:1.1.0
"

for IMAGE in ${IMAGES}
do
  FROM_IMAGE=${QUAY_HOST}/${IMAGE}
  TO_IMAGE=${REGISTRY_HOST}/${IMAGE}

  docker pull ${FROM_IMAGE}
  docker tag ${FROM_IMAGE} ${TO_IMAGE}
  docker push ${TO_IMAGE}
done
