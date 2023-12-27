#!/usr/bin/env bash

source $(dirname "$0")/functions_acs.sh

create_user "service-account-storage-service" "service-account-storage-service@example.com" $(generate_alfpwd)
add_user_to_group "service-account-storage-service" "ALFRESCO_ADMINISTRATORS"

if [[ "$LOAD_TEST_DATA" == "true" ]]
then
  create_user "admin.adf" "admin.adf@alfresco.com"
  add_user_to_group "admin.adf" "ALFRESCO_MODEL_ADMINISTRATORS"

  create_user "superadminuser" "superadminuser@test.com"
  add_user_to_group "superadminuser" "ALFRESCO_ADMINISTRATORS"
  add_user_to_group "superadminuser" "ALFRESCO_MODEL_ADMINISTRATORS"
fi
