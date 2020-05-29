#!/usr/bin/env bash

HELM_EXE="${HELM_EXE:-helm}"
CHART_REPO="${CHART_REPO:-helm}"
DIR_NAME=$(basename "${PWD}")
CHART_NAME=${CHART_NAME:-${DIR_NAME%%-deployment}}

"$HELM_EXE" repo add activiti https://activiti.github.io/activiti-cloud-helm-charts
"$HELM_EXE" repo add alfresco https://kubernetes-charts.alfresco.com/stable
"$HELM_EXE" repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
"$HELM_EXE" dep up "$CHART_REPO/$CHART_NAME"

"$HELM_EXE" upgrade --install --reuse-values ${HELM_OPTS[*]} "${RELEASE_NAME:-$CHART_NAME}" "$CHART_REPO/$CHART_NAME"
