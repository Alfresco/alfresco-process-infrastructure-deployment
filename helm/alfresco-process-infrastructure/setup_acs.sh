#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/functions_acs.sh"

create_user "service-account-storage-service1" "service-account-storage-service@example.com" "$(generate_alfpwd)"
sleep 1
add_user_to_group "service-account-storage-service1" "ALFRESCO_ADMINISTRATORS"

if [[ "$LOAD_TEST_DATA" == "true" ]]
then
  create_user "admin.adf" "admin.adf@alfresco.com"
  sleep 1
  add_user_to_group "admin.adf" "ALFRESCO_MODEL_ADMINISTRATORS"

  create_user "superadminuser" "superadminuser@test.com"
  sleep 1
  add_user_to_group "superadminuser" "ALFRESCO_ADMINISTRATORS"
  sleep 1
  add_user_to_group "superadminuser" "ALFRESCO_MODEL_ADMINISTRATORS"
fi
