#!/usr/bin/env bash

# CERT ARN for envalfresco.com
APS_DOMAIN="${APS_HOST#*.*}"
APS_INGRESS_AWS_CERT_ARN=${APS_INGRESS_AWS_CERT_ARN:-$(aws acm list-certificates --query "CertificateSummaryList[?contains(DomainName,'${APS_DOMAIN}')].CertificateArn" --output text)}
env | grep APS | sort

cat << EOF > values.yaml
controller:
  publishService:
    enabled: true
  config:
    ssl-redirect: "false"
    use-proxy-protocol: "false"
EOF

if [[ -n "${APS_INGRESS_AWS_CERT_ARN}" ]]
then
  cat << EOF >> values.yaml
service:
  targetPorts:
    http: http
    https: http
  annotations:
    external-dns.alpha.kubernetes.io/hostname: ${APS_HOST}.
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "${APS_INGRESS_AWS_CERT_ARN}"
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "https"
    service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: '3600'
EOF

  echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
  echo add ${APS_HOST} to DNS with: external-dns --provider aws --source service --source ingress --once --dry-run
fi

# check AWS from cli
# APS_AWS_HOSTED_ZONE=$(aws route53 list-hosted-zones --query "HostedZones[?Name == '${APS_DOMAIN}.'].Id | [0]" --output text)
# aws route53 list-resource-record-sets --hosted-zone-id ${APS_AWS_HOSTED_ZONE} --query "ResourceRecordSets[?contains(Name,'${APS_HOST/.*}')].Name"
# aws route53 change-resource-record-sets --hosted-zone-id ${APS_AWS_HOSTED_ZONE} --change-batch change-resource-record-sets.json

CHART_NAME="stable/nginx-ingress"

HELM_OPTS="${HELM_OPTS} -f values.yaml"
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME}
else
  helm upgrade --install --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
fi

rm values.yaml
