#!/bin/bash

VERSION=$(grep -m1 version version helm/alfresco-process-infrastructure/Chart.yaml | awk '{ print $2 }' | sed 's/[", ]//g')

echo "git tag -a ${VERSION} -m ${VERSION}"
git config --local user.name "alfresco-build"
git config --local user.email "build@alfresco.com"
git tag -a ${VERSION} -m "${VERSION} [ci skip] "
git remote rm origin
GITHUB_REPO=https://$GITHUB_TOKEN:x-oauth-basic@github.com/Alfresco/alfresco-process-infrastructure-deployment.git
git remote add origin $GITHUB_REPO
git push origin --tags
