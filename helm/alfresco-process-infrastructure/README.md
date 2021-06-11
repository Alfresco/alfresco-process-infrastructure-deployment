# alfresco-process-infrastructure

![Version: 7.1.0-M14](https://img.shields.io/badge/Version-7.1.0--M14-informational?style=flat-square) ![AppVersion: 7.1.0-M14](https://img.shields.io/badge/AppVersion-7.1.0--M14-informational?style=flat-square)

A Helm chart for Alfresco Activiti Enterprise infrastructure

**Homepage:** <https://github.com/Alfresco/alfresco-process-infrastructure>

## Source Code

* <https://github.com/Alfresco/alfresco-process-infrastructure>

## Requirements

Kubernetes: `>=1.15.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 7.1.0-M13 |
| https://charts.bitnami.com/bitnami | postgresql | 9.1.1 |
| https://charts.bitnami.com/bitnami | rabbitmq | 7.8.0 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-identity-service | 3.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alfresco-admin-app.applications.allowCustomResources | bool | `true` |  |
| alfresco-admin-app.enabled | bool | `true` |  |
| alfresco-admin-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-admin-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-admin-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-admin-app.extraEnv | string | `"- name: APP_ALLOW_CUSTOM_RESOURCES\n  value: \"{{ .Values.applications.allowCustomResources }}\"\n{{- if .Values.global.acs.enabled }}\n- name: APP_CONFIG_ECM_HOST\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n{{- end }}"` |  |
| alfresco-admin-app.image.pullPolicy | string | `"Always"` |  |
| alfresco-admin-app.image.repository | string | `"quay.io/alfresco/alfresco-admin-app"` |  |
| alfresco-admin-app.image.tag | string | `"develop"` |  |
| alfresco-admin-app.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-admin-app.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"Authorization, Content-Type, Accept"` |  |
| alfresco-admin-app.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-admin-app.ingress.path | string | `"/admin"` |  |
| alfresco-admin-app.nameOverride | string | `"alfresco-admin-app"` |  |
| alfresco-admin-app.resources.limits.cpu | string | `"500m"` |  |
| alfresco-admin-app.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-admin-app.resources.requests.cpu | string | `"200m"` |  |
| alfresco-admin-app.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-admin-app.service.envType | string | `"frontend"` |  |
| alfresco-admin-app.service.name | string | `"admin-app"` |  |
| alfresco-deployment-service.applications.activiti.keycloak.clientPassword | string | `"client"` | activiti keycloak client password |
| alfresco-deployment-service.applications.connectors.emailConnector | object | `{"host":"","password":"","port":"","username":""}` | In order to apply default account configuration to the email connector, all the variables need to be set. All email connectors in every application in the cluster will share the same account. |
| alfresco-deployment-service.applications.connectors.emailConnector.host | string | `""` | email host |
| alfresco-deployment-service.applications.connectors.emailConnector.password | string | `""` | email password |
| alfresco-deployment-service.applications.connectors.emailConnector.port | string | `""` | email port |
| alfresco-deployment-service.applications.connectors.emailConnector.username | string | `""` | email username |
| alfresco-deployment-service.applications.database.external | bool | `true` |  |
| alfresco-deployment-service.applications.image.pullPolicy | string | `"Always"` | default pull policy for all images used in application |
| alfresco-deployment-service.applications.image.tag | string | `"develop"` | default tag for all images used in application |
| alfresco-deployment-service.applications.maxNumber | int | 20 applications can be deployed by default | maximum number of application can be deployed |
| alfresco-deployment-service.applications.processStorageService.clientSecret | string | `"08102f0f-025c-4226-8a3e-674343bff231"` | client secret for process storage |
| alfresco-deployment-service.applications.rabbitmq.admin.url | string | `""` | RabbitMQ admin URL, derived from host if not set |
| alfresco-deployment-service.applications.rabbitmq.host | string | `"{{ .Release.Name }}-rabbitmq.{{ .Release.Namespace }}"` | RabbitMQ host |
| alfresco-deployment-service.applications.rabbitmq.password | string | `"CHANGEME"` | RabbitMQ password |
| alfresco-deployment-service.applications.rabbitmq.username | string | `"user"` | RabbitMQ username |
| alfresco-deployment-service.db.password | string | `"alfresco"` |  |
| alfresco-deployment-service.db.uri | string | `"jdbc:postgresql://{{ .Release.Name }}-{{ .Values.postgresql.name }}.{{ .Release.Namespace }}:{{ .Values.postgresql.port }}/postgres"` |  |
| alfresco-deployment-service.db.username | string | `"alfresco"` |  |
| alfresco-deployment-service.enabled | bool | `true` |  |
| alfresco-deployment-service.environment.apiToken | string | `""` | kubernetes API Token Create a service account alfresco-deployment-service and retrieve its token: $ kubectl create serviceaccount -n kube-system alfresco-deployment-service $ kubectl create clusterrolebinding alfresco-deployment-service-admin-binding --clusterrole cluster-admin --serviceaccount=kube-system:alfresco-deployment-service $ kubectl -n kube-system get secret $(kubectl -n kube-system get serviceaccount alfresco-deployment-service -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode |
| alfresco-deployment-service.environment.apiUrl | string | `""` | kubernetes API URL, $ kubectl config view -o jsonpath='{.clusters[0].cluster.server}' |
| alfresco-deployment-service.environment.namespace | string | installation namespace | namespace to copy secrets from to application namespaces |
| alfresco-deployment-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_SERVLET_CONTEXTPATH\n  value: \"{{ .Values.ingress.path }}\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: KEYCLOAK_AUTH_SERVER_URL\n  value: '{{ include \"common.keycloak-url\" . }}'\n- name: DOCKER_REGISTRY_IMAGE_TAG\n  value: \"{{ .Values.applications.image.tag }}\"\n- name: ALFRESCO_DOCKER_REGISTRY_IMAGEPULLPOLICY\n  value: \"{{ .Values.applications.image.pullPolicy }}\"\n- name: CONTENT_SERVICE_BASE_URL\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n- name: CONTENT_SERVICE_ENABLED\n  value: \"{{ .Values.global.acs.enabled }}\"\n{{- with .Values.global.acs.activemq.url }}\n- name: CONTENT_SERVICE_ACTIVEMQ_URL\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.global.acs.activemq.username }}\n- name: CONTENT_SERVICE_ACTIVEMQ_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.global.acs.activemq.password }}\n- name: CONTENT_SERVICE_ACTIVEMQ_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n- name: MODELING_URL\n  value: '{{ include \"common.gateway-url\" . }}/modeling-service'\n- name: ENVIRONMENT_HOST_URL\n  value: '{{ include \"common.gateway-url\" . }}'\n- name: ENVIRONMENT_API_URL\n  value: \"{{ .Values.environment.apiUrl }}\"\n- name: ENVIRONMENT_API_TOKEN\n  value: \"{{ .Values.environment.apiToken }}\"\n- name: ENVIRONMENT_NAMESPACE\n  value: \"{{ tpl .Values.environment.namespace . }}\"\n- name: PROJECT_RELEASE_VOLUME_STORAGE_CLASS\n  value: \"{{ .Values.projectReleaseVolume.storageClass }}\"\n- name: PROJECT_RELEASE_VOLUME_PERMISSION\n  value: \"{{ .Values.projectReleaseVolume.permission }}\"\n- name: APPLICATIONS_DATABASE_EXTERNAL\n  value: \"{{ .Values.applications.database.external }}\"\n{{- with .Values.applications.connectors.emailConnector.username }}\n- name: CONNECTOR_EMAILCONNECTOR_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.password }}\n- name: CONNECTOR_EMAILCONNECTOR_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.host }}\n- name: CONNECTOR_EMAILCONNECTOR_HOST\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.port }}\n- name: CONNECTOR_EMAILCONNECTOR_PORT\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.maxNumber }}\n- name: APPLICATIONS_MAXNUMBER\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.processStorageService.clientSecret }}\n- name: PROCESS_STORAGE_SERVICE_CLIENTSECRET\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.activiti.keycloak.clientPassword }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.host }}\n- name: APPLICATIONS_RABBITMQ_HOST\n  value: \"{{ tpl .Values.applications.rabbitmq.host . }}\"\n{{- end }}\n{{- with .Values.applications.rabbitmq.username }}\n- name: APPLICATIONS_RABBITMQ_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.rabbitmq.password }}\n- name: APPLICATIONS_RABBITMQ_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.admin.url }}\n- name: APPLICATIONS_RABBITMQ_ADMIN_URL\n  value: \"{{ tpl .Values.applications.rabbitmq.admin.url . }}\"\n{{- end }}\n- name: ATS_TRANSFORMER_TIKA_URL\n  value: \"http://tika.{{ .Release.Namespace }}/transform\""` |  |
| alfresco-deployment-service.extraVolumeMounts | string | `"- name: license\n  mountPath: \"/root/.activiti/enterprise-license/\"\n  readOnly: true"` |  |
| alfresco-deployment-service.extraVolumes | string | `"- name: config\n  configMap:\n    name: {{ .Release.Name }}-deployment-config\n    defaultMode: 0744\n- name: license\n  secret:\n    secretName: licenseaps"` |  |
| alfresco-deployment-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-deployment-service.image.repository | string | `"quay.io/alfresco/alfresco-deployment-service"` |  |
| alfresco-deployment-service.image.tag | string | `"develop"` |  |
| alfresco-deployment-service.ingress.enabled | bool | `true` |  |
| alfresco-deployment-service.ingress.path | string | `"/deployment-service"` |  |
| alfresco-deployment-service.nameOverride | string | `"alfresco-deployment-service"` |  |
| alfresco-deployment-service.postgresql.enabled | bool | `true` |  |
| alfresco-deployment-service.probePath | string | `"{{ .Values.ingress.path }}/actuator/health"` |  |
| alfresco-deployment-service.projectReleaseVolume.permission | string | `"ReadWriteMany"` | permission for project release volume |
| alfresco-deployment-service.projectReleaseVolume.storageClass | string | `"#{null}"` | storage class for project release volume, set to null spring expression to use default |
| alfresco-deployment-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-identity-service.enabled | bool | `true` |  |
| alfresco-identity-service.extraEnv | string | `"- name: KEYCLOAK_USER\n  value: admin\n- name: KEYCLOAK_PASSWORD\n  value: admin\n- name: KEYCLOAK_IMPORT\n  value: /realm/alfresco-realm.json\n- name: PROXY_ADDRESS_FORWARDING\n  value: \"true\"\n"` |  |
| alfresco-identity-service.ingress.enabled | bool | `false` |  |
| alfresco-identity-service.keycloak.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-identity-service.keycloak.ingress.annotations."nginx.ingress.kubernetes.io/affinity" | string | `"cookie"` |  |
| alfresco-identity-service.keycloak.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"false"` |  |
| alfresco-identity-service.keycloak.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"128k"` |  |
| alfresco-identity-service.keycloak.ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-hash" | string | `"sha1"` |  |
| alfresco-identity-service.keycloak.ingress.annotations."nginx.ingress.kubernetes.io/session-cookie-name" | string | `"identity_affinity_route"` |  |
| alfresco-identity-service.keycloak.ingress.enabled | bool | `true` |  |
| alfresco-identity-service.keycloak.ingress.rules[0].host | string | `"{{ include \"common.keycloak-host\" . }}"` |  |
| alfresco-identity-service.keycloak.ingress.rules[0].paths[0] | string | `"/auth"` |  |
| alfresco-identity-service.keycloak.ingress.tls | list | `[]` |  |
| alfresco-identity-service.keycloak.keycloak.image.tag | string | `"1.4.0"` |  |
| alfresco-identity-service.keycloak.postgresql.imageTag | float | `11.7` |  |
| alfresco-identity-service.keycloak.postgresql.persistence.existingClaim | string | `""` |  |
| alfresco-identity-service.keycloak.postgresql.tls.enabled | bool | `false` |  |
| alfresco-identity-service.rbac.create | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.client.redirectUris[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.client.webOrigins[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].clientId | string | `"activiti"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].directAccessGrantsEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].implicitFlowEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].redirectUris[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].webOrigins[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[1].authorizationServicesEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[1].clientId | string | `"storage-service"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[1].directAccessGrantsEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[1].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[1].secret | string | `"08102f0f-025c-4226-8a3e-674343bff231"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[0].name | string | `"hr"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[0].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[1].name | string | `"sales"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[1].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[2].name | string | `"testgroup"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[3].name | string | `"processadmin"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[3].realmRoles[0] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[0].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[0].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[0].name | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[1].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[1].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[1].name | string | `"ACTIVITI_DEVOPS"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[2].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[2].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[2].name | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[3].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[3].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[3].name | string | `"ACTIVITI_MODELER"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[2] | string | `"query-realms"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[3] | string | `"query-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[4] | string | `"manage-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[5] | string | `"manage-authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[6] | string | `"manage-realm"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].composites.client.realm-management[7] | string | `"manage-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].description | string | `"user is able to see the identity section"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[4].name | string | `"ACTIVITI_IDENTITY"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.broker[0] | string | `"read-token"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[0] | string | `"manage-users"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[1] | string | `"manage-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[2] | string | `"manage-authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[3] | string | `"manage-events"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[4] | string | `"manage-realm"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[5] | string | `"create-client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[6] | string | `"impersonation"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].clientRoles.realm-management[7] | string | `"realm-admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].credentials[0].value | string | `"client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].email | string | `"client@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].firstName | string | `"client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].lastName | string | `"client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[1] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[2] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].username | string | `"client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].email | string | `"modeler-qa@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].firstName | string | `"Modeler"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].realmRoles[2] | string | `"ACTIVITI_MODELER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[10].username | string | `"modeler-qa"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.broker[0] | string | `"read-token"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[0] | string | `"manage-users"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[1] | string | `"manage-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[2] | string | `"manage-authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[3] | string | `"manage-events"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[4] | string | `"manage-realm"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[5] | string | `"create-client"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[6] | string | `"impersonation"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.realm-management[7] | string | `"realm-admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].email | string | `"superadminuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].firstName | string | `"Super Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[1] | string | `"ACTIVITI_IDENTITY"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[2] | string | `"ACTIVITI_DEVOPS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[3] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[4] | string | `"ACTIVITI_MODELER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[5] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[6] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].username | string | `"superadminuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].email | string | `"devopsuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].firstName | string | `"DevOps"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[2] | string | `"ACTIVITI_DEVOPS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].username | string | `"devopsuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].email | string | `"hruser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].firstName | string | `"HR"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].groups[0] | string | `"/hr"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[2] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].username | string | `"hruser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].email | string | `"processadminuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].firstName | string | `"Process Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].groups[0] | string | `"/processadmin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[2] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].username | string | `"processadminuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].email | string | `"salesuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].firstName | string | `"Sales"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].groups[0] | string | `"/sales"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].realmRoles[2] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[5].username | string | `"salesuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].email | string | `"testuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].firstName | string | `"Test"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].groups[0] | string | `"/testgroup"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].realmRoles[2] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[6].username | string | `"testuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].email | string | `"testadmin@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].firstName | string | `"Test"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].groups[0] | string | `"/testgroup"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].lastName | string | `"Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].realmRoles[2] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].realmRoles[3] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[7].username | string | `"testadmin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].email | string | `"identityuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].firstName | string | `"Identity"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].lastName | string | `"Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].realmRoles[2] | string | `"ACTIVITI_IDENTITY"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[8].username | string | `"identityuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].email | string | `"modeler@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].firstName | string | `"Modeler"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].realmRoles[2] | string | `"ACTIVITI_MODELER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[9].username | string | `"modeler"` |  |
| alfresco-identity-service.serviceAccount.create | bool | `false` |  |
| alfresco-modeling-app.enabled | bool | `true` |  |
| alfresco-modeling-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-modeling-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_ECM_HOST | string | `"{{ template \"alfresco-process-infrastructure.acs-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-modeling-app.image.pullPolicy | string | `"Always"` |  |
| alfresco-modeling-app.image.repository | string | `"quay.io/alfresco/alfresco-modeling-app"` |  |
| alfresco-modeling-app.image.tag | string | `"develop"` |  |
| alfresco-modeling-app.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-modeling-app.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"Authorization, Content-Type, Accept"` |  |
| alfresco-modeling-app.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-modeling-app.ingress.path | string | `"/modeling"` |  |
| alfresco-modeling-app.nameOverride | string | `"alfresco-modeling-app"` |  |
| alfresco-modeling-app.resources.limits.cpu | string | `"500m"` |  |
| alfresco-modeling-app.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-modeling-app.resources.requests.cpu | string | `"200m"` |  |
| alfresco-modeling-app.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-modeling-app.service.envType | string | `"frontend"` |  |
| alfresco-modeling-app.service.name | string | `"modeling-app"` |  |
| alfresco-modeling-service.activiti.keycloak.clientPassword | string | `"client"` | activiti keycloak client password |
| alfresco-modeling-service.content.client.id | string | `""` |  |
| alfresco-modeling-service.content.client.secret | string | `""` |  |
| alfresco-modeling-service.content.service.path | string | `"alfresco"` |  |
| alfresco-modeling-service.db.password | string | `"alfresco"` |  |
| alfresco-modeling-service.db.uri | string | `"jdbc:postgresql://{{ .Release.Name }}-{{ .Values.postgresql.name }}:{{ .Values.postgresql.port }}/postgres"` |  |
| alfresco-modeling-service.db.username | string | `"alfresco"` |  |
| alfresco-modeling-service.enabled | bool | `true` |  |
| alfresco-modeling-service.exampleProjects.endpoint | string | `"https://alfrescolabs.github.io/apa-templates.github.io"` |  |
| alfresco-modeling-service.exampleProjects.resource | string | `"index_7.1.0-GA.json"` |  |
| alfresco-modeling-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: CONTENT_CLIENT_ID\n  value: \"{{ .Values.content.client.id }}\"\n- name: CONTENT_CLIENT_SECRET\n  value: \"{{ .Values.content.client.secret }}\"\n- name: CONTENT_SERVICE_URL\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n- name: CONTENT_SERVICE_PATH\n  value: \"{{ .Values.content.service.path }}\"\n{{- with .Values.activiti.keycloak.clientPassword }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n- name: ACT_ALFRESCO_MODELING_TEMPLATES_ENDPOINT\n  value: \"{{ .Values.exampleProjects.endpoint }}\"\n- name: ACT_ALFRESCO_MODELING_TEMPLATES_RESOURCE\n  value: \"{{ .Values.exampleProjects.resource }}\""` |  |
| alfresco-modeling-service.extraVolumeMounts | string | `"- name: license\n  mountPath: \"/root/.activiti/enterprise-license/\"\n  readOnly: true"` |  |
| alfresco-modeling-service.extraVolumes | string | `"- name: license\n  secret:\n    secretName: licenseaps"` |  |
| alfresco-modeling-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-modeling-service.image.repository | string | `"quay.io/alfresco/alfresco-modeling-service"` |  |
| alfresco-modeling-service.image.tag | string | `"develop"` |  |
| alfresco-modeling-service.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| alfresco-modeling-service.ingress.enabled | bool | `true` |  |
| alfresco-modeling-service.ingress.path | string | `""` |  |
| alfresco-modeling-service.ingress.subPaths[0] | string | `"/modeling-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[1] | string | `"/dmn-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[2] | string | `"/script-service/?(.*)"` |  |
| alfresco-modeling-service.javaOpts.other | string | `"-XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true -XX:+UseParallelGC -XX:MinHeapFreeRatio=5 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90"` |  |
| alfresco-modeling-service.javaOpts.xms | string | `"512m"` |  |
| alfresco-modeling-service.javaOpts.xmx | string | `"3072m"` |  |
| alfresco-modeling-service.liquibase.enabled | bool | `true` |  |
| alfresco-modeling-service.nameOverride | string | `"alfresco-modeling-service"` |  |
| alfresco-modeling-service.postgresql.enabled | bool | `true` |  |
| alfresco-modeling-service.probePath | string | `"/actuator/health"` |  |
| alfresco-modeling-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-tika-service.enabled | bool | `true` |  |
| alfresco-tika-service.image.repository | string | `"alfresco/alfresco-tika"` |  |
| alfresco-tika-service.image.tag | string | `"2.3.6"` |  |
| alfresco-tika-service.ingress.enabled | bool | `false` |  |
| alfresco-tika-service.javaOpts.other | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| alfresco-tika-service.livenessProbe.path | string | `"/live"` |  |
| alfresco-tika-service.nameOverride | string | `"alfresco-tika-service"` |  |
| alfresco-tika-service.readinessProbe.path | string | `"/ready"` |  |
| alfresco-tika-service.resources.limits.memory | string | `"1000Mi"` |  |
| alfresco-tika-service.resources.requests.memory | string | `"1000Mi"` |  |
| alfresco-tika-service.service.internalPort | int | `8090` |  |
| alfresco-tika-service.service.name | string | `"tika"` |  |
| global | object | `{"acs":{"activemq":{"password":"","url":"","username":""},"admin":{"password":"","username":""},"enabled":false,"host":"{{ template \"common.gateway-host\" . }}","url":""},"gateway":{"annotations":{},"domain":"","host":"{{ template \"common.gateway-domain\" . }}","http":"false","tlsacme":"false"},"keycloak":{"host":"{{ template \"common.gateway-host\" . }}","realm":"alfresco","resource":"alfresco","url":""},"registryPullSecrets":["quay-registry-secret"]}` | for common values see https://github.com/Activiti/activiti-cloud-common-chart/blob/master/charts/common/README.md |
| global.acs.activemq.url | string | `""` | ACS ActiveMQ URL for events |
| global.acs.activemq.username | string | `""` | ACS ActiveMQ password |
| global.acs.admin | object | `{"password":"","username":""}` | admin credentials to setup required users/groups/acl on ACS |
| global.acs.admin.password | string | `""` | ACS admin password |
| global.acs.admin.username | string | `""` | ACS admin username |
| global.acs.enabled | bool | `false` | enable support for ACS |
| global.acs.host | string | `"{{ template \"common.gateway-host\" . }}"` | host for content services |
| global.acs.url | string | `""` | set full url to configure external ACS, https://acs.mydomain.com without /alfresco |
| global.gateway.annotations | object | `{}` | Configure global annotations for all service ingresses |
| global.gateway.domain | string | `""` | Set to configure gateway domain template, i.e. {{ .Release.Namespace }}.1.3.4.5.nip.io $ helm upgrade aae . --install --set global.gateway.domain=1.2.3.4.nip.io |
| global.gateway.host | string | `"{{ template \"common.gateway-domain\" . }}"` | Set to configure single host domain name for all services, i.e. "{{ .Release.Namespace }}.{{ template "common.gateway-domain" . }}" |
| global.gateway.http | string | `"false"` | Set to false enables HTTPS configuration on all urls |
| global.gateway.tlsacme | string | `"false"` | Set to enable automatic TLS for ingress if https is enabled |
| global.keycloak.host | string | `"{{ template \"common.gateway-host\" . }}"` | Configure Keycloak host template, i.e. "{{ .Release.Namespace }}.{{ .Values.global.gateway.domain }}" |
| global.keycloak.realm | string | `"alfresco"` | Configure Keycloak realm |
| global.keycloak.resource | string | `"alfresco"` | Configure Keycloak resource |
| global.keycloak.url | string | `""` | Set full url to configure external Keycloak, https://keycloak.mydomain.com/auth |
| global.registryPullSecrets | list | `["quay-registry-secret"]` | Configure pull secrets for all deployments |
| postgresql.commonAnnotations.application | string | `"activiti"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.repository | string | `"postgres"` |  |
| postgresql.image.tag | float | `11.7` |  |
| postgresql.persistence.mountPath | string | `"/data"` |  |
| postgresql.postgresqlConfiguration.log_min_messages | string | `"LOG"` |  |
| postgresql.postgresqlConfiguration.max_connections | int | `300` |  |
| postgresql.postgresqlDataDir | string | `"/data/pgdata"` |  |
| postgresql.postgresqlDatabase | string | `"postgres"` |  |
| postgresql.postgresqlPassword | string | `"alfresco"` |  |
| postgresql.postgresqlUsername | string | `"alfresco"` |  |
| postgresql.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql.resources.requests.memory | string | `"1500Mi"` |  |
| rabbitmq.auth.erlangCookie | string | `"ylY79lOdNUWsJEwAGdVQnhjSazV4QZKO="` |  |
| rabbitmq.auth.password | string | `"CHANGEME"` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.customLivenessProbe.exec.command[0] | string | `"rabbitmq-diagnostics"` |  |
| rabbitmq.customLivenessProbe.exec.command[1] | string | `"status"` |  |
| rabbitmq.customLivenessProbe.initialDelaySeconds | int | `60` |  |
| rabbitmq.customLivenessProbe.periodSeconds | int | `60` |  |
| rabbitmq.customLivenessProbe.timeoutSeconds | int | `15` |  |
| rabbitmq.customReadinessProbe.exec.command[0] | string | `"rabbitmq-diagnostics"` |  |
| rabbitmq.customReadinessProbe.exec.command[1] | string | `"ping"` |  |
| rabbitmq.customReadinessProbe.initialDelaySeconds | int | `20` |  |
| rabbitmq.customReadinessProbe.periodSeconds | int | `60` |  |
| rabbitmq.enabled | bool | `true` |  |
| rabbitmq.extraPlugins | string | `""` |  |
| rabbitmq.livenessProbe.enabled | bool | `false` |  |
| rabbitmq.persistence.accessMode | string | `"ReadWriteOnce"` |  |
| rabbitmq.persistence.storageClass | string | `nil` |  |
| rabbitmq.readinessProbe.enabled | bool | `false` |  |
| rabbitmq.resources.limits.memory | string | `"1500Mi"` |  |
| rabbitmq.resources.requests.memory | string | `"1500Mi"` |  |
| setup-acs-script-job.enabled | bool | `true` |  |
| setup-acs-script-job.image.repository | string | `"bitnami/minideb-extras"` |  |
| setup-acs-script-job.image.tag | string | `"stretch"` |  |
| setup-acs-script-job.loadTestData | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.3.0](https://github.com/norwoodj/helm-docs/releases/v1.3.0)
