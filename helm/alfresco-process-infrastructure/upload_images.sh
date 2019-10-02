#!/usr/bin/env bash

QUAY_HOST=${QUAY_HOST:-quay.io}
echo uploading to ${REGISTRY_HOST}

# 5 min timeout
REGISTRY_URL="https://${REGISTRY_HOST}/v2/"
echo "connecting to ${REGISTRY_URL}"
COUNTER=0

while [[ $COUNTER -lt 300 && "$(curl -u ${REGISTRY_USER}:${REGISTRY_PASSWORD} -s -o /dev/null -w '%{http_code}' ${REGISTRY_URL})" != "200" ]]
do
  echo "."
  sleep 5
  let COUNTER=COUNTER+1
done
echo "connection OK"

if [[ -n "${REGISTRY_USER}" ]]
then
  echo Login to ${REGISTRY_HOST} using user ${REGISTRY_USER}
  docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY_HOST}
fi

if [[ -n "${QUAY_USER}" ]]
then
  echo Login to ${QUAY_HOST} using user ${QUAY_USER}
  docker login -u ${QUAY_USER} -p ${QUAY_PASSWORD} ${QUAY_HOST}
fi

IMAGES="
  alfresco/alfresco-process-query-service:7.1.0.M4
  alfresco/alfresco-process-audit-service:7.1.0.M4
  alfresco/alfresco-process-storage-service:7.1.0.M4
  alfresco/alfresco-process-notifications-graphql-service:7.1.0.M4
  alfresco/alfresco-preference-service:7.1.0.M4
  alfresco/alfresco-process-workspace-app:7.1.0.M4
  alfresco/alfresco-process-camel-connector-service:7.1.0.M4
  alfresco/alfresco-process-email-connector-service:7.1.0.M4
  alfresco/alfresco-process-lambda-connector-service:7.1.0.M4
  alfresco/alfresco-process-rest-connector-service:7.1.0.M4
  alfresco/alfresco-process-salesforce-connector-service:7.1.0.M4
  alfresco/alfresco-process-slack-connector-service:7.1.0.M4
  alfresco/alfresco-process-twilio-connector-service:7.1.0.M4
  alfresco/alfresco-digital-workspace:1.1.0
  alfresco/alfresco-dbp-connector-service:0.5
"

for IMAGE in ${IMAGES}
do
  FROM_IMAGE=${QUAY_HOST}/${IMAGE}
  TO_IMAGE=${REGISTRY_HOST}/${IMAGE}

  docker pull ${FROM_IMAGE}
  docker tag ${FROM_IMAGE} ${TO_IMAGE}
  docker push ${TO_IMAGE}
done
