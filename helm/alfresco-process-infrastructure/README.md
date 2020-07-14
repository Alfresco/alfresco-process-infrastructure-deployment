alfresco-process-infrastructure
===============================
A Helm chart for Alfresco Activiti Enterprise infrastructure

Current chart version is `7.1.0-M9`

Source code can be found [here](https://github.com/Alfresco/alfresco-process-infrastructure)

## Chart Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | common | 1.1.44 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-adf-app | 2.2.1 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-adf-app | 2.2.1 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-identity-service | 2.1.0 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-process-springboot-service | 2.2.1 |
| https://kubernetes-charts.alfresco.com/stable | alfresco-process-springboot-service | 2.2.1 |
| https://kubernetes-charts.storage.googleapis.com | postgresql | 6.3.9 |
| https://kubernetes-charts.storage.googleapis.com | postgresql | 6.3.9 |

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alfresco-admin-app.applications.allow_custom_resources | bool | `true` |  |
| alfresco-admin-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-admin-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-admin-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-admin-app.extraEnv | string | `"- name: APP_ALLOW_CUSTOM_RESOURCES\n  value: \"{{ .Values.applications.allow_custom_resources }}\"\n"` |  |
| alfresco-admin-app.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-admin-app.image.repository | string | `"quay.io/alfresco/alfresco-admin-app"` |  |
| alfresco-admin-app.image.tag | string | `"develop"` |  |
| alfresco-admin-app.ingress.hostName | string | `nil` |  |
| alfresco-admin-app.ingress.path | string | `"/admin"` |  |
| alfresco-admin-app.nameOverride | string | `"alfresco-admin-app"` |  |
| alfresco-deployment-service.alfresco-content-services.activemq.password | string | `""` |  |
| alfresco-deployment-service.alfresco-content-services.activemq.url | string | `""` | ACS ActiveMQ URL for events |
| alfresco-deployment-service.alfresco-content-services.activemq.username | string | `""` | ACS ActiveMQ password |
| alfresco-deployment-service.alfresco-content-services.enabled | bool | `true` |  |
| alfresco-deployment-service.applications.connectors.emailConnector | object | `{"host":"","password":"","port":"","username":""}` | In order to apply default account configuration to the email connector, all the variables need to be set. All email connectors in every application in the cluster will share the same account. |
| alfresco-deployment-service.applications.connectors.emailConnector.host | string | `""` | email host |
| alfresco-deployment-service.applications.connectors.emailConnector.password | string | `""` | email password |
| alfresco-deployment-service.applications.connectors.emailConnector.port | string | `""` | email port |
| alfresco-deployment-service.applications.connectors.emailConnector.username | string | `""` | email username |
| alfresco-deployment-service.applications.database.external | bool | `false` |  |
| alfresco-deployment-service.applications.max_number | int | 20 applications can be deployed by default | maximum number of application can be deployed |
| alfresco-deployment-service.connectorVolume.permission | string | `"ReadWriteMany"` |  |
| alfresco-deployment-service.connectorVolume.storageClass | string | `"default-sc"` |  |
| alfresco-deployment-service.dind.image.repository | string | `"docker"` |  |
| alfresco-deployment-service.dind.image.tag | string | `"18.06.1-dind"` |  |
| alfresco-deployment-service.dockerRegistry.password | string | `""` |  |
| alfresco-deployment-service.dockerRegistry.secretName | string | `"aps2-registry-secret"` |  |
| alfresco-deployment-service.dockerRegistry.server | string | `""` |  |
| alfresco-deployment-service.dockerRegistry.userName | string | `""` |  |
| alfresco-deployment-service.enabled | bool | `true` |  |
| alfresco-deployment-service.environment.apiToken | string | `""` |  |
| alfresco-deployment-service.environment.apiUrl | string | `""` |  |
| alfresco-deployment-service.environment.namespace | string | installation namespace | namespace to copy secrets from to application namespaces |
| alfresco-deployment-service.extraContainers | string | `"- name: dind\n  image: \"{{ .Values.dind.image.repository }}:{{ .Values.dind.image.tag }}\"\n  imagePullPolicy: IfNotPresent\n  securityContext:\n    privileged: true\n  tty: true\n  env:\n  - name: DOCKER_HOST\n    value: tcp://localhost:2375\n  resources:\n    requests:\n      cpu: 1\n      memory: 1024Mi\n    limits:\n      cpu: 2\n      memory: 2048Mi\n  volumeMounts:\n  - mountPath: /var/lib/docker\n    name: docker-daemon\n"` |  |
| alfresco-deployment-service.extraEnv | string | `"- name: DOCKER_HOST\n  value: tcp://localhost:2375\n- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_SERVLET_CONTEXTPATH\n  value: \"{{ .Values.ingress.path }}\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: KEYCLOAK_AUTH_SERVER_URL\n  value: '{{ include \"common.keycloak-url\" . }}'\n- name: DOCKER_REGISTRY_SERVER\n  value: \"{{ .Values.dockerRegistry.server }}\"\n- name: DOCKER_REGISTRY_USERNAME\n  value: \"{{ .Values.dockerRegistry.userName }}\"\n- name: DOCKER_REGISTRY_PASSWORD\n  value: '{{ .Values.dockerRegistry.password }}'\n- name: DOCKER_REGISTRY_SECRET_NAME\n  value: \"{{ .Values.dockerRegistry.secretName }}\"\n- name: DOCKER_REGISTRY_IMAGE_TAG\n  value: \"develop\"\n- name: CONTENT_SERVICE_BASE_URL\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n- name: CONTENT_SERVICE_ENABLED\n  value: '{{ index .Values \"alfresco-content-services\" \"enabled\" }}'\n{{- with index .Values \"alfresco-content-services\" \"activemq\" \"url\" }}\n- name: CONTENT_SERVICE_ACTIVEMQ_URL\n  value: \"{{ . }}\"\n{{- end }}\n{{- with index .Values \"alfresco-content-services\" \"activemq\" \"username\" }}\n- name: CONTENT_SERVICE_ACTIVEMQ_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with index .Values \"alfresco-content-services\" \"activemq\" \"password\" }}\n- name: CONTENT_SERVICE_ACTIVEMQ_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n- name: MODELING_URL\n  value: '{{ include \"common.gateway-url\" . }}/modeling-service'\n- name: ENVIRONMENT_HOST_URL\n  value: '{{ include \"common.gateway-url\" . }}'\n- name: ENVIRONMENT_API_URL\n  value: \"{{ .Values.environment.apiUrl }}\"\n- name: ENVIRONMENT_API_TOKEN\n  value: \"{{ .Values.environment.apiToken }}\"\n- name: ENVIRONMENT_NAMESPACE\n  value: \"{{ tpl .Values.environment.namespace . }}\"\n- name: PROJECT_RELEASE_VOLUME_STORAGE_CLASS\n  value: \"{{ .Values.connectorVolume.storageClass }}\"\n- name: PROJECT_RELEASE_VOLUME_PERMISSION\n  value: \"{{ .Values.connectorVolume.permission }}\"\n- name: APPLICATIONS_DATABASE_EXTERNAL\n  value: \"{{ .Values.applications.database.external }}\"\n{{- with .Values.applications.connectors.emailConnector.username }}\n- name: CONNECTOR_EMAILCONNECTOR_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.password }}\n- name: CONNECTOR_EMAILCONNECTOR_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.host }}\n- name: CONNECTOR_EMAILCONNECTOR_HOST\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.port }}\n- name: CONNECTOR_EMAILCONNECTOR_PORT\n  value: \"{{ . }}\"\n{{- end }}\n- name: APPLICATIONS_MAXNUMBER\n  value: \"{{ .Values.applications.max_number }}\"\n"` |  |
| alfresco-deployment-service.extraInit.image.repository | string | `"bitnami/minideb-extras"` |  |
| alfresco-deployment-service.extraInit.image.tag | string | `"stretch"` |  |
| alfresco-deployment-service.extraVolumeMounts | string | `"- name: license\n  mountPath: \"/root/.activiti/enterprise-license/\"\n  readOnly: true\n"` |  |
| alfresco-deployment-service.extraVolumes | string | `"- name: config\n  configMap:\n    name: {{ .Release.Name }}-deployment-config\n    defaultMode: 0744\n- name: docker-daemon\n  emptyDir: {}\n- name: license\n  secret:\n    secretName: licenseaps\n"` |  |
| alfresco-deployment-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-deployment-service.image.repository | string | `"quay.io/alfresco/alfresco-deployment-service"` |  |
| alfresco-deployment-service.image.tag | string | `"develop"` |  |
| alfresco-deployment-service.ingress.enabled | bool | `true` |  |
| alfresco-deployment-service.ingress.path | string | `"/deployment-service"` |  |
| alfresco-deployment-service.postgres.enabled | bool | `true` |  |
| alfresco-deployment-service.postgres.name | string | `"postgresql-ads"` |  |
| alfresco-deployment-service.postgres.password | string | `"alfresco"` |  |
| alfresco-deployment-service.postgres.username | string | `"alfresco"` |  |
| alfresco-deployment-service.probePath | string | `"{{ .Values.ingress.path }}/actuator/health"` |  |
| alfresco-deployment-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-deployment-service.rbac.create | bool | `false` |  |
| alfresco-deployment-service.serviceAccount.create | bool | `false` |  |
| alfresco-identity-service.enabled | bool | `true` |  |
| alfresco-identity-service.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"false"` |  |
| alfresco-identity-service.ingress.common.enabled | bool | `true` |  |
| alfresco-identity-service.ingress.enabled | bool | `false` |  |
| alfresco-identity-service.keycloak.ingress.enabled | bool | `false` |  |
| alfresco-identity-service.keycloak.keycloak.extraArgs | string | `"-Dkeycloak.import=/realm/alfresco-aps-realm.json"` |  |
| alfresco-identity-service.keycloak.keycloak.extraEnv | string | `"- name: PROXY_ADDRESS_FORWARDING\n  value: \"true\"\n"` |  |
| alfresco-identity-service.keycloak.keycloak.service.port | int | `80` |  |
| alfresco-identity-service.keycloak.postgresql.imageTag | string | `"11.3"` |  |
| alfresco-identity-service.keycloak.postgresql.persistence.existingClaim | string | `nil` |  |
| alfresco-identity-service.realm.alfresco.client.redirectUris[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.client.webOrigins[0] | string | `"*"` |  |
| alfresco-infrastructure.nginx-ingress.enabled | bool | `false` |  |
| alfresco-modeling-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-modeling-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_ECM_HOST | string | `"{{ template \"alfresco-process-infrastructure.acs-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_OAUTH2_SILENT_LOGIN | string | `"true"` |  |
| alfresco-modeling-app.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-modeling-app.image.repository | string | `"quay.io/alfresco/alfresco-modeling-app"` |  |
| alfresco-modeling-app.image.tag | string | `"develop"` |  |
| alfresco-modeling-app.ingress.path | string | `"/modeling"` |  |
| alfresco-modeling-app.nameOverride | string | `"alfresco-modeling-app"` |  |
| alfresco-modeling-service.content.client.id | string | `""` |  |
| alfresco-modeling-service.content.client.secret | string | `""` |  |
| alfresco-modeling-service.content.service.path | string | `"alfresco"` |  |
| alfresco-modeling-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: ACT_KEYCLOAK_URL\n  value: '{{ include \"common.keycloak-url\" . }}'\n- name: CONTENT_CLIENT_ID\n  value: \"{{ .Values.content.client.id }}\"\n- name: CONTENT_CLIENT_SECRET\n  value: \"{{ .Values.content.client.secret }}\"\n- name: CONTENT_SERVICE_URL\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n- name: CONTENT_SERVICE_PATH\n  value: \"{{ .Values.content.service.path }}\"\n"` |  |
| alfresco-modeling-service.extraVolumeMounts | string | `"- name: license\n  mountPath: \"/root/.activiti/enterprise-license/\"\n  readOnly: true\n"` |  |
| alfresco-modeling-service.extraVolumes | string | `"- name: license\n  secret:\n    secretName: licenseaps\n"` |  |
| alfresco-modeling-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-modeling-service.image.repository | string | `"quay.io/alfresco/alfresco-modeling-service"` |  |
| alfresco-modeling-service.image.tag | string | `"develop"` |  |
| alfresco-modeling-service.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| alfresco-modeling-service.ingress.enabled | bool | `true` |  |
| alfresco-modeling-service.ingress.path | string | `""` |  |
| alfresco-modeling-service.ingress.subPaths[0] | string | `"/modeling-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[1] | string | `"/dmn-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[2] | string | `"/script-service/?(.*)"` |  |
| alfresco-modeling-service.nameOverride | string | `"alfresco-modeling-service"` |  |
| alfresco-modeling-service.postgres.enabled | bool | `true` |  |
| alfresco-modeling-service.postgres.name | string | `"postgresql-ams"` |  |
| alfresco-modeling-service.postgres.password | string | `"alfresco"` |  |
| alfresco-modeling-service.postgres.username | string | `"alfresco"` |  |
| alfresco-modeling-service.probePath | string | `"/actuator/health"` |  |
| alfresco-modeling-service.rbac.create | bool | `false` |  |
| alfresco-modeling-service.serviceAccount.create | bool | `false` |  |
| global | object | `{"acs":{"admin":{"password":"","username":""},"host":"{{ template \"common.gateway-host\" . }}","url":""},"gateway":{"annotations":{},"domain":"REPLACEME","host":"{{ template \"common.gateway-domain\" . }}","http":"false","tlsacme":"false"},"keycloak":{"host":"{{ template \"common.gateway-domain\" . }}","realm":"alfresco","resource":"activiti","url":""},"registryPullSecrets":["quay-registry-secret"]}` | for common values see https://github.com/Activiti/activiti-cloud-common-chart/blob/master/charts/common/README.md |
| global.acs.admin | object | `{"password":"","username":""}` | admin credentials to setup required users/groups/acl on ACS |
| global.acs.host | string | `"{{ template \"common.gateway-host\" . }}"` | host for content services |
| global.acs.url | string | `""` | set full url to configure external ACS, https://acs.mydomain.com without /alfresco |
| global.gateway.annotations | object | `{}` | Configure global annotations for all service ingresses |
| global.gateway.domain | string | `"REPLACEME"` | Set to configure gateway domain template, i.e. {{ .Release.Namespace }}.1.3.4.5.nip.io  helm upgrade activiti . --install --set global.gateway.domain=1.2.3.4.nip.io |
| global.gateway.host | string | `"{{ template \"common.gateway-domain\" . }}"` | Set to configure single host domain name for all services, i.e. "{{ .Release.Namespace }}.{{ template "common.gateway-domain" . }}" |
| global.gateway.http | string | `"false"` | Set to false enables HTTPS configuration on all urls |
| global.gateway.tlsacme | string | `"false"` | Set to enable automatic TLS for ingress if https is enabled |
| global.keycloak.host | string | `"{{ template \"common.gateway-domain\" . }}"` | Configure Keycloak host template, i.e. "{{ .Release.Namespace }}.{{ .Values.global.gateway.domain }}" |
| global.keycloak.realm | string | `"alfresco"` | Configure Keycloak realm |
| global.keycloak.resource | string | `"activiti"` | Configure Keycloak resource |
| global.keycloak.url | string | `""` | Set full url to configure external Keycloak, https://keycloak.mydomain.com/auth |
| global.registryPullSecrets | list | `["quay-registry-secret"]` | Configure pull secrets for all deployments |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.baseSize | string | `"100Gi"` |  |
| persistence.enabled | bool | `false` |  |
| postgresql-ads.image.repository | string | `"postgres"` |  |
| postgresql-ads.image.tag | float | `11.4` |  |
| postgresql-ads.postgresqlConfiguration.log_min_messages | string | `"LOG"` |  |
| postgresql-ads.postgresqlConfiguration.max_connections | int | `300` |  |
| postgresql-ads.postgresqlDataDir | string | `"/var/lib/postgresql/data/pgdata"` |  |
| postgresql-ads.postgresqlDatabase | string | `"postgres"` |  |
| postgresql-ads.postgresqlPassword | string | `"alfresco"` |  |
| postgresql-ads.postgresqlUsername | string | `"alfresco"` |  |
| postgresql-ads.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql-ads.resources.requests.memory | string | `"1500Mi"` |  |
| postgresql-ams.image.repository | string | `"postgres"` |  |
| postgresql-ams.image.tag | float | `11.4` |  |
| postgresql-ams.postgresqlConfiguration.log_min_messages | string | `"LOG"` |  |
| postgresql-ams.postgresqlConfiguration.max_connections | int | `300` |  |
| postgresql-ams.postgresqlDataDir | string | `"/var/lib/postgresql/data/pgdata"` |  |
| postgresql-ams.postgresqlDatabase | string | `"postgres"` |  |
| postgresql-ams.postgresqlPassword | string | `"alfresco"` |  |
| postgresql-ams.postgresqlUsername | string | `"alfresco"` |  |
| postgresql-ams.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql-ams.resources.requests.memory | string | `"1500Mi"` |  |
| setup-acs-script-job.enabled | bool | `true` |  |
| setup-acs-script-job.image.repository | string | `"bitnami/minideb-extras"` |  |
| setup-acs-script-job.image.tag | string | `"stretch"` |  |
