#!/usr/bin/env bash

NEW_VERSION=paas
sed -i.bak -e "s/7.1.0-M9/$NEW_VERSION/" values.yaml
