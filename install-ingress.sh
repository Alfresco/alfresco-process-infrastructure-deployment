#!/usr/bin/env bash

source $(dirname "$0")/env.sh

# CERT ARN for envalfresco.com
ENV_AWS_CERT_ARN=${ENV_AWS_CERT_ARN:-"arn:aws:acm:us-east-1:175125429442:certificate/59628920-98d9-4009-90bc-5e626716cc82"}

cat << EOF > values.yaml
controller:
  config:
    ssl-redirect: "false"
    use-proxy-protocol: "false"
EOF

if [[ -n "${ENV_AWS_CERT_ARN}" ]]
then
cat << EOF >> values.yaml
  service:
    targetPorts:
      http: http
      https: http
    annotations:
      external-dns.alpha.kubernetes.io/hostname: ${ENV_FQDN}.
      service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "${ENV_AWS_CERT_ARN}"
      service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
      service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "https"
      service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: '3600'
EOF
echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
echo add ${ENV_FQDN} to DNS with: external-dns --provider aws --source service --once
fi

CHART_NAME="stable/nginx-ingress"
VERSION=${VERSION:-0.14.0}

HELM_OPTS="${HELM_OPTS} -f values.yaml"
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME}
else
  helm upgrade --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
fi

rm values.yaml
