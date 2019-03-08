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
HELM_OPTS="${HELM_OPTS} -f values.yaml --name docker-registry"
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME} --set storage=s3 --set s3.region=<region>,s3.regionEndpoint=s3.us-east-1.amazonaws.com,s3.bucket=<bucketname> --set secrets.s3.accessKey=<aws_access_key_id>,secrets.s3.secretKey=<aws_access_key_password>
else
  helm upgrade --install --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME} --set storage=s3 --set s3.region=<region> --set s3.regionEndpoint=s3.us-east-1.amazonaws.com --set s3.bucket=<bucketname> --set secrets.s3.accessKey=<aws_access_key_id>,secrets.s3.secretKey=<aws_access_key_password>
fi

rm values.yaml

echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
echo add ${APS_REGISTRY_HOST} to DNS with: external-dns --registry txt --txt-owner-id ${APS_HOST} --provider aws --source service --source ingress --once --dry-run
