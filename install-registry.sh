#!/usr/bin/env bash

[[ -n "${APS_SCRIPTS_HOME}" ]] || echo APS_SCRIPTS_HOME is not set
source ${APS_SCRIPTS_HOME}/env_aps.sh
env | grep APS_REGISTRY | sort

cat << EOF > values.yaml
ingress:
  enabled: true
  hosts:
  - ${APS_REGISTRY_HOST}
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
service:
  type: ClusterIP
EOF

CHART_NAME="stable/docker-registry"
HELM_OPTS="${HELM_OPTS} -f values.yaml"
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME}
else
  helm upgrade --install --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
fi

rm values.yaml

echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
echo add ${APS_REGISTRY_HOST} to DNS with: external-dns --provider aws --source service --source ingress --once --dry-run
