#!/usr/bin/env bash

CHART_NAME="alfresco-process-services-infrastructure"
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm dependency update helm/${CHART_NAME}
helm dependency build helm/${CHART_NAME}

if [[ -z "${RELEASE_NAME}" ]]
then
    helm install helm/${CHART_NAME}
else
    helm upgrade "${RELEASE_NAME}" helm/${CHART_NAME}
fi
