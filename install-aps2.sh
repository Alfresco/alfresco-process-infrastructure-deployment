#!/usr/bin/env bash

touch values.yaml

if [[ -n "${EFS_HOST}" ]]
then
cat << EOF >> values.yaml
  persistence:
    efs:
      enabled: true
      dns: "${EFS_HOST}"
EOF
fi

HELM_OPTS="${HELM_OPTS} -f values.yaml" ./install.sh

rm    values.yaml
