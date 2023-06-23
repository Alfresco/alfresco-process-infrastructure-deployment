#!/usr/bin/env bash

ACS_URL=${ACS_URL:-http://host.docker.internal}
REPOSITORY_URL=${REPOSITORY_URL:-${ACS_URL}/alfresco}
REPOSITORY_ADMIN_USER=${REPOSITORY_ADMIN_USER:-admin}
REPOSITORY_ADMIN_PASSWORD=${REPOSITORY_ADMIN_PASSWORD:-admin}

# 5 min timeout
echo "connecting to ${REPOSITORY_URL}"
COUNTER=0
while [[ $COUNTER -lt 300 && "$(curl -s -o /dev/null -w '%{http_code}' "${REPOSITORY_URL}/api/-default-/public/alfresco/versions/1/probes/-ready-")" != "200" ]]
do
  echo "."
  sleep 5
  (( ++COUNTER ))
done
echo "connection OK"

create_user() {
  local ACS_USER="$1"
  local ACS_EMAIL="${2:-${ACS_USER}@example.com}"
  local ACS_PASSWORD="${3:-password}"
  echo "create user ${ACS_USER}"

  curl --fail -X POST \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    --user "${REPOSITORY_ADMIN_USER}:${REPOSITORY_ADMIN_PASSWORD}" \
    -d "{
    \"id\": \"${ACS_USER}\",
    \"firstName\": \"${ACS_USER}\",
    \"lastName\": \"User\",
    \"email\": \"${ACS_EMAIL}\",
    \"password\": \"${ACS_PASSWORD}\"
  }" "${REPOSITORY_URL}/api/-default-/public/alfresco/versions/1/people" \
  || { echo "cannot create user ${ACS_USER}"; exit 1; }

  echo
}

create_group() {
  local ACS_GROUP="$1";
  echo "create group ${ACS_GROUP}"

  curl --fail -X POST \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    --user "${REPOSITORY_ADMIN_USER}:${REPOSITORY_ADMIN_PASSWORD}" \
    -d "{
    \"id\": \"GROUP_${ACS_GROUP}\"
  }" "${REPOSITORY_URL}/api/-default-/public/alfresco/versions/1/groups" \
  || { echo "cannot create group ${ACS_GROUP}"; exit 1; }

  echo
}

generate_alfpwd() {
  local LANG=POSIX
  grep -ao '\w' /dev/urandom | tr -d '\n' | dd bs=1 count=64 2>/dev/null
}

add_user_to_group() {
  local ACS_USER="$1" ACS_GROUP="$2";
  echo "add user ${ACS_USER} to group ${ACS_GROUP}"

  curl --fail -X POST \
    --header 'Content-Type: application/json' --header 'Accept: application/json' \
    --user "${REPOSITORY_ADMIN_USER}:${REPOSITORY_ADMIN_PASSWORD}" \
    -d "{
    \"id\": \"${ACS_USER}\",
    \"memberType\": \"PERSON\"
  }" "${REPOSITORY_URL}/api/-default-/public/alfresco/versions/1/groups/GROUP_${ACS_GROUP}/members" \
  || { echo "cannot add user ${ACS_USER} to group ${ACS_GROUP}"; exit 1; }

  echo
}
