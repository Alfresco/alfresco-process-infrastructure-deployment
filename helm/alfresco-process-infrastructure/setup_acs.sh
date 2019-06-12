#!/usr/bin/env bash

source $(dirname "$0")/functions_acs.sh

create_group "APS_MODELING"
create_group "APS_DEVOPS"

create_user "devopsuser"
add_user_to_group "devopsuser" "APS_MODELING"
add_user_to_group "devopsuser" "APS_DEVOPS"

create_user "processadminuser"
add_user_to_group "processadminuser" "APS_MODELING"
add_user_to_group "processadminuser" "APS_DEVOPS"

create_user "superadminuser"
add_user_to_group "superadminuser" "APS_MODELING"
add_user_to_group "superadminuser" "APS_DEVOPS"

create_user "modeler" "modeler@alfresco.com"
add_user_to_group "modeler" "APS_MODELING"
add_user_to_group "modeler" "APS_DEVOPS"

create_user "qa-modeler-1" "qa-modeler-1@alfresco.com"
add_user_to_group "qa-modeler-1" "APS_MODELING"
add_user_to_group "qa-modeler-1" "APS_DEVOPS"

create_user "service-account-modeling-service"
add_user_to_group "service-account-modeling-service" "ALFRESCO_MODEL_ADMINISTRATORS"

create_user "admin.adf" "admin.adf@alfresco.com"
add_user_to_group "admin.adf" "ALFRESCO_MODEL_ADMINISTRATORS"
add_user_to_group "admin.adf" "APS_MODELING"
add_user_to_group "admin.adf" "APS_DEVOPS"

create_user "service-account-storage-service"
add_user_to_group "service-account-storage-service" "ALFRESCO_ADMINISTRATORS"

