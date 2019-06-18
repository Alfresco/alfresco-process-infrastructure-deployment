#!/usr/bin/env bash

source $(dirname "$0")/functions_acs.sh

create_user "service-account-storage-service"
add_user_to_group "service-account-storage-service" "ALFRESCO_ADMINISTRATORS"

create_user "admin.adf" "admin.adf@alfresco.com"
add_user_to_group "admin.adf" "ALFRESCO_MODEL_ADMINISTRATORS"
