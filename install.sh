#!/usr/bin/env bash

CHART_NAME="alfresco-process-services-infrastructure"
helm repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
helm dependency update helm/${CHART_NAME}

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} \
    helm/${CHART_NAME}
else
  helm upgrade --reuse-values ${HELM_OPTS} \
    "${RELEASE_NAME}" helm/${CHART_NAME}
fi
