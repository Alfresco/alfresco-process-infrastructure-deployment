#!/usr/bin/env bash

[[ -n "${APS_SCRIPTS_HOME}" ]] || echo APS_SCRIPTS_HOME is not set
source ${APS_SCRIPTS_HOME}/env_aps.sh
source ${APS_SCRIPTS_HOME}/env_aws.sh
env | grep APS_REGISTRY | sort
env | grep AWS | sort

cat << EOF > values.yaml
ingress:
  enabled: true
  hosts:
  - ${APS_REGISTRY_HOST}
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/proxy-body-size: "0"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "600"
    nginx.ingress.kubernetes.io/proxy-send-timeout: "600"
service:
  type: ClusterIP
storage: s3
s3:
  region: ${AWS_REGION}
  bucket: ${APS_AWS_BUCKET_NAME:-${APS_HOST}-registry}
secrets:
  s3:
    accessKey: ${AWS_ACCESS_KEY_ID}
    secretKey: ${AWS_SECRET_ACCESS_KEY}
EOF

CHART_NAME="stable/docker-registry"

HELM_OPTS="${HELM_OPTS} -f values.yaml"
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

RELEASE_NAME="${RELEASE_NAME:-docker-registry}"

helm upgrade --install --force --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}

rm values.yaml

echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
echo add ${APS_REGISTRY_HOST} to DNS with: external-dns --registry txt --txt-owner-id ${APS_HOST} --provider aws --source service --source ingress --once --dry-run
