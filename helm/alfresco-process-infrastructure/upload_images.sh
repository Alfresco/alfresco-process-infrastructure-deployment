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
  alfresco/alfresco-process-query-service:develop
  alfresco/alfresco-process-audit-service:develop
  alfresco/alfresco-process-storage-service:develop
  alfresco/alfresco-process-notifications-graphql-service:develop
  alfresco/alfresco-process-workspace-app:develop
  alfresco/alfresco-process-camel-connector-service:develop
  alfresco/alfresco-process-email-connector-service:develop
  alfresco/alfresco-process-lambda-connector-service:develop
  alfresco/alfresco-process-rest-connector-service:develop
  alfresco/alfresco-process-salesforce-connector-service:develop
  alfresco/alfresco-process-slack-connector-service:develop
  alfresco/alfresco-process-twilio-connector-service:develop
  alfresco/alfresco-digital-workspace:1.1.0
  alfresco/alfresco-dbp-connector-service:master
  alfresco/alfresco-preference-service:develop
"

for IMAGE in ${IMAGES}
do
  FROM_IMAGE=${QUAY_HOST}/${IMAGE}
  TO_IMAGE=${REGISTRY_HOST}/${IMAGE}

  docker pull ${FROM_IMAGE}
  docker tag ${FROM_IMAGE} ${TO_IMAGE}
  docker push ${TO_IMAGE}
done
