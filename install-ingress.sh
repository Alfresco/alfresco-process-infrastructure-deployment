#!/usr/bin/env bash

# CERT ARN for envalfresco.com
APS_DOMAIN="${APS_DOMAIN:-${APS_HOST#*.*}}"
APS_INGRESS_AWS_CERT_ARN=${APS_INGRESS_AWS_CERT_ARN:-$(aws acm list-certificates --query "CertificateSummaryList[?DomainName=='${APS_DOMAIN}'].CertificateArn" --output text)}
env | grep APS | sort

# custom headers config https://kubernetes.github.io/ingress-nginx/examples/customization/custom-headers/
# configmap can be edited and hot reload will happen: kubectl edit configmaps nginx-ingress-controller
# see the last line on how to test: kubectl exec nginx-ingress-controller-<pod_name> cat /etc/nginx/nginx.conf
# for background details on why we need to customise template for websockets on SSL: https://www.built.io/blog/websockets-on-aws-s-elb

kubectl create configmap nginx-template --from-file nginx.tmpl

cat << EOF > values.yaml
controller:
  publishService:
    enabled: true
  customTemplate:
    configMapName: nginx-template
    configMapKey: nginx.tmpl
  service:
    enableHttps: false
  config:
    generate-request-id: "true"
    proxy-read-timeout: "3600"
    proxy-send-timeout: "3600"
    ssl-redirect: "false"
    use-forwarded-headers: "false"
    use-proxy-protocol: "true"
EOF


if [[ -n "${APS_INGRESS_AWS_CERT_ARN}" ]]
then
  cat << EOF >> values.yaml
  annotations:
    # Enable PROXY protocol
#    service.beta.kubernetes.io/aws-load-balancer-proxy-protocol: "*"
    # Specify SSL certificate to use
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert: "${APS_INGRESS_AWS_CERT_ARN}"
    # Use SSL on the HTTPS port
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: "https" # needed to have the correct inbound rule
#    external-dns.alpha.kubernetes.io/hostname: ${APS_HOST}.
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: "http"
#    service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: "3600"
EOF

  echo install external-dns with: go get -u -v github.com/kubernetes-incubator/external-dns
  echo add ${APS_HOST} to DNS with: external-dns --registry txt --txt-owner-id ${APS_HOST} --provider aws --source service --source ingress --once --dry-run
fi

# manually change the rule to by SSL to TCP

# to be done on CLI as enable proxy doesn't work - https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-proxy-protocol.html
export NGINX_INGRESS_CONTROLLER_NAME=nginx-ingress-controller
export ELB_ADDRESS=$(kubectl get services ${NGINX_INGRESS_CONTROLLER_NAME} -o jsonpath={.status.loadBalancer.ingress[0].hostname})
export ELB_NAME=${ELB_ADDRESS%%-*}

export ELB_INSTANCE_PORT=$(kubectl get services ${NGINX_INGRESS_CONTROLLER_NAME} -o jsonpath={.spec.ports[0].nodePort})
aws elb create-load-balancer-policy --load-balancer-name ${ELB_NAME} --policy-name my-ProxyProtocol-policy --policy-type-name ProxyProtocolPolicyType --policy-attributes AttributeName=ProxyProtocol,AttributeValue=true
aws elb set-load-balancer-policies-for-backend-server --load-balancer-name ${ELB_NAME} --instance-port $ELB_INSTANCE_PORT
# check with: aws elb describe-load-balancers --load-balancer-name ${ELB_NAME}

# check AWS from cli
# APS_AWS_HOSTED_ZONE=$(aws route53 list-hosted-zones --query "HostedZones[?Name == '${APS_DOMAIN}.'].Id | [0]" --output text)
# aws route53 list-resource-record-sets --hosted-zone-id ${APS_AWS_HOSTED_ZONE} --query "ResourceRecordSets[?contains(Name,'${APS_HOST/.*}')].Name"
# aws route53 change-resource-record-sets --hosted-zone-id ${APS_AWS_HOSTED_ZONE} --change-batch change-resource-record-sets.json


# TEST
# websockets working (install with npm -g install wscat): wscat --connect wss://activiti-cloud-gateway.${DOMAIN}/ws/graphql
# httptrace endpoint to check x-forwarded-* headers:
# open a URL: https://activiti-cloud-gateway.${DOMAIN}/activiti-cloud-modeling-backend/actuator and check scheme
# read httptrace: https://activiti-cloud-gateway.${DOMAIN}/activiti-cloud-modeling-backend/actuator/httptrace

CHART_NAME="stable/nginx-ingress"

HELM_OPTS="${HELM_OPTS} -f values.yaml"

VERSION=${VERSION:-1.1.5}
[[ -n "${VERSION}" ]] && HELM_OPTS="${HELM_OPTS} --version ${VERSION}"

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install ${HELM_OPTS} ${CHART_NAME}
else
  helm upgrade --install --reuse-values ${HELM_OPTS} ${RELEASE_NAME} ${CHART_NAME}
fi

rm values.yaml
