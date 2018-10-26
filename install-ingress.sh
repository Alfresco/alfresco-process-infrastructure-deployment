#!/usr/bin/env bash

cat << EOF > ingress-values.yaml
rbac:
  create: true
controller:
  config:
    ssl-redirect: "false"
    use-proxy-protocol: "false"
EOF

if [[ -z "${RELEASE_NAME}" ]]
then
  helm install -f ingress-values.yaml --version 0.14.0 stable/nginx-ingress
else
  helm upgrade --reuse-values -f ingress-values.yaml --version 0.14.0 "${RELEASE_NAME}" stable/nginx-ingress
fi

rm ingress-values.yaml
