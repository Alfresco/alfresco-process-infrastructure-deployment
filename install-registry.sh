#!/usr/bin/env bash

# a DNS entry should be created pointing to the ingress ELB
REGISTRY_HOST=${REGISTRY_HOST:-aps2mteodori-registry.envalfresco.com}

cat << EOF > values.yaml
ingress:
  enabled: true
  hosts:
  - ${REGISTRY_HOST}
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
service:
  type: ClusterIP
EOF

CHART_NAME="stable/docker-registry"
HELM_OPTS="${HELM_OPTS} -f values.yaml"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME}
else
  helm upgrade --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
fi

rm values.yaml
