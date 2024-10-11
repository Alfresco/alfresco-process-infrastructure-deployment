# alfresco-process-infrastructure

![Version: 7.19.0-rc.140](https://img.shields.io/badge/Version-7.19.0--rc.140-informational?style=flat-square) ![AppVersion: 7.19.0-rc.140](https://img.shields.io/badge/AppVersion-7.19.0--rc.140-informational?style=flat-square)

A Helm chart for Alfresco Activiti Enterprise infrastructure

**Homepage:** <https://github.com/Alfresco/alfresco-process-infrastructure-deployment>

## Source Code

* <https://github.com/Alfresco/alfresco-process-infrastructure-deployment>

## Requirements

Kubernetes: `>=1.15.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-process-analytics-service(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-tika-service(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-modeling-service(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-static-resources(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-identity-adapter-service(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-modeling-app(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-admin-app(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-deployment-service(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-process-analytics-playground(common) | 8.7.0-alpha.1 |
| https://activiti.github.io/activiti-cloud-helm-charts | common | 8.7.0-alpha.1 |
| https://codecentric.github.io/helm-charts | alfresco-identity-service(keycloakx) | 2.3.0 |
| https://opensearch-project.github.io/helm-charts | opensearch | 1.11.1 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami | postgresql | 15.5.11 |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami | rabbitmq | 14.4.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alfresco-admin-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-admin-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-admin-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-admin-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-admin-app.applications.allowCustomResources | bool | `true` |  |
| alfresco-admin-app.enabled | bool | `true` |  |
| alfresco-admin-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-admin-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-admin-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-admin-app.extraEnv | string | `"- name: APP_ALLOW_CUSTOM_RESOURCES\n  value: \"{{ .Values.applications.allowCustomResources }}\"\n{{- if .Values.global.acs.enabled }}\n- name: APP_CONFIG_ECM_HOST\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n{{- else }}\n- name: APP_CONFIG_PROVIDER\n  value: BPM\n{{- end }}"` |  |
| alfresco-admin-app.image.pullPolicy | string | `"Always"` |  |
| alfresco-admin-app.image.repository | string | `"quay.io/alfresco/alfresco-admin-app"` |  |
| alfresco-admin-app.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-admin-app.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"Authorization, Content-Type, Accept"` |  |
| alfresco-admin-app.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-admin-app.ingress.className | string | `"nginx"` |  |
| alfresco-admin-app.ingress.path | string | `"/admin"` |  |
| alfresco-admin-app.nameOverride | string | `"alfresco-admin-app"` |  |
| alfresco-admin-app.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-admin-app.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-admin-app.replicaCount | int | `2` |  |
| alfresco-admin-app.resources.limits.cpu | string | `"500m"` |  |
| alfresco-admin-app.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-admin-app.resources.requests.cpu | string | `"200m"` |  |
| alfresco-admin-app.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-admin-app.service.envType | string | `"frontend"` |  |
| alfresco-admin-app.service.name | string | `"admin-app"` |  |
| alfresco-deployment-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-deployment-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-deployment-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-deployment-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-deployment-service.applications.activiti.keycloak.clientId | string | `"{{ .Values.global.keycloak.clientId }}"` | activiti keycloak client id |
| alfresco-deployment-service.applications.activiti.keycloak.clientSecret | string | `"{{ .Values.global.keycloak.clientSecret }}"` | activiti keycloak client secret |
| alfresco-deployment-service.applications.analytics.metrics.export.enabled | bool | `true` |  |
| alfresco-deployment-service.applications.analytics.metrics.export.password | string | `"admin"` |  |
| alfresco-deployment-service.applications.analytics.metrics.export.url | string | `"http://opensearch-cluster-master.{{ .Release.Namespace }}.svc.cluster.local:9200"` |  |
| alfresco-deployment-service.applications.analytics.metrics.export.username | string | `"admin"` |  |
| alfresco-deployment-service.applications.connectors.emailConnector | object | `{"host":"","password":"","port":"","username":""}` | In order to apply default account configuration to the email connector, all the variables need to be set. All email connectors in every application in the cluster will share the same account. |
| alfresco-deployment-service.applications.connectors.emailConnector.host | string | `""` | email host |
| alfresco-deployment-service.applications.connectors.emailConnector.password | string | `""` | email password |
| alfresco-deployment-service.applications.connectors.emailConnector.port | string | `""` | email port |
| alfresco-deployment-service.applications.connectors.emailConnector.username | string | `""` | email username |
| alfresco-deployment-service.applications.customRedirectUris | string | `""` | custom URIs to allow for local development |
| alfresco-deployment-service.applications.database.external | bool | `true` |  |
| alfresco-deployment-service.applications.datadog.agent.admission | bool | `true` | enables Datadog trace agent admission webhook for runtime applications. |
| alfresco-deployment-service.applications.datadog.agent.logsInjection | bool | `true` | enables Datadog trace agent logs injection support for runtime applications. |
| alfresco-deployment-service.applications.datadog.agent.profiling | bool | `false` | enables Datadog trace agent profiling support for runtime applications. |
| alfresco-deployment-service.applications.datadog.enabled | bool | `true` | enables application Datadog observability conditional on global.datadog.enabled=true |
| alfresco-deployment-service.applications.datadog.env | string | `"{{ .Values.global.datadog.env }}"` |  |
| alfresco-deployment-service.applications.datadog.metrics.enabled | bool | `true` | enables application Datadog metrics observability. |
| alfresco-deployment-service.applications.image.pullPolicy | string | `"Always"` | default pull policy for all application images |
| alfresco-deployment-service.applications.image.pullSecretName | string | `"quay-registry-secret"` | pull secret name for all application images |
| alfresco-deployment-service.applications.image.tag | string | `"7.19.0-rc.140"` | default tag for all application images |
| alfresco-deployment-service.applications.maxNumber | int | 20 applications can be deployed by default | maximum number of application can be deployed |
| alfresco-deployment-service.applications.podDisruptionBudget.enabled | bool | `true` | set to true to enable PodDisruptionBudget for all applications |
| alfresco-deployment-service.applications.podDisruptionBudget.minAvailable | int | `1` | default min replicas to keep for all applications |
| alfresco-deployment-service.applications.processStorageService.clientSecret | string | `"08102f0f-025c-4226-8a3e-674343bff231"` | client secret for process storage |
| alfresco-deployment-service.applications.rabbitmq.admin.url | string | `""` | RabbitMQ admin URL, derived from host if not set |
| alfresco-deployment-service.applications.rabbitmq.host | string | `"{{ .Release.Name }}-rabbitmq.{{ .Release.Namespace }}"` | RabbitMQ host |
| alfresco-deployment-service.applications.rabbitmq.password | string | `"CHANGEME"` | RabbitMQ password |
| alfresco-deployment-service.applications.rabbitmq.port | string | `""` | RabbitMQ port |
| alfresco-deployment-service.applications.rabbitmq.ssl.enabled | string | `""` | RabbitMQ SSL enabled |
| alfresco-deployment-service.applications.rabbitmq.username | string | `"user"` | RabbitMQ username |
| alfresco-deployment-service.applications.replicaCount | int | `2` | default number of replicas for all applications |
| alfresco-deployment-service.db.password | string | `"alfresco"` |  |
| alfresco-deployment-service.db.uri | string | `"jdbc:postgresql://{{ .Release.Name }}-{{ .Values.postgresql.name }}.{{ .Release.Namespace }}:{{ .Values.postgresql.port }}/postgres"` |  |
| alfresco-deployment-service.db.username | string | `"alfresco"` |  |
| alfresco-deployment-service.enabled | bool | `true` |  |
| alfresco-deployment-service.environment.apiToken | string | `""` | kubernetes API Token Create a service account alfresco-deployment-service and retrieve its token: $ kubectl create serviceaccount -n kube-system alfresco-deployment-service $ kubectl create clusterrolebinding alfresco-deployment-service-admin-binding --clusterrole cluster-admin --serviceaccount=kube-system:alfresco-deployment-service $ kubectl -n kube-system get secret $(kubectl -n kube-system get serviceaccount alfresco-deployment-service -o jsonpath='{.secrets[0].name}') -o jsonpath='{.data.token}' | base64 --decode |
| alfresco-deployment-service.environment.apiUrl | string | `""` | kubernetes API URL, $ kubectl config view -o jsonpath='{.clusters[0].cluster.server}' |
| alfresco-deployment-service.environment.namespace | string | installation namespace | namespace to copy secrets from to application namespaces |
| alfresco-deployment-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_SERVLET_CONTEXTPATH\n  value: \"{{ .Values.ingress.path }}\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: KEYCLOAK_AUTH_SERVER_URL\n  value: '{{ include \"common.keycloak-url\" . }}'\n- name: DOCKER_REGISTRY_IMAGE_TAG\n  value: \"{{ .Values.applications.image.tag }}\"\n- name: ALFRESCO_DOCKER_REGISTRY_SECRET_NAME\n  value: \"{{ .Values.applications.image.pullSecretName }}\"\n- name: ALFRESCO_DOCKER_REGISTRY_IMAGEPULLPOLICY\n  value: \"{{ .Values.applications.image.pullPolicy }}\"\n- name: CONTENT_SERVICE_BASE_URL\n{{- if .Values.global.hxpr.enabled}}\n  value: \"{{ .Values.global.hxpr.url }}\"\n{{- else }}\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n{{- end }}\n- name: CONTENT_SERVICE_ENABLED\n  value: \"{{ or .Values.global.acs.enabled .Values.global.hxpr.enabled }}\"\n{{- with .Values.global.acs.activemq.url }}\n- name: CONTENT_SERVICE_ACTIVEMQ_URL\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.global.acs.activemq.username }}\n- name: CONTENT_SERVICE_ACTIVEMQ_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.global.acs.activemq.password }}\n- name: CONTENT_SERVICE_ACTIVEMQ_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n- name: MODELING_URL\n  value: '{{ include \"common.gateway-url\" . }}/modeling-service'\n- name: ENVIRONMENT_HOST_URL\n  value: '{{ include \"common.gateway-url\" . }}'\n- name: ENVIRONMENT_API_URL\n  value: \"{{ .Values.environment.apiUrl }}\"\n- name: ENVIRONMENT_API_TOKEN\n  value: \"{{ .Values.environment.apiToken }}\"\n- name: ENVIRONMENT_NAMESPACE\n  value: \"{{ tpl .Values.environment.namespace . }}\"\n- name: ENVIRONMENT_DOMAIN\n  value: '{{ include \"common.gateway-domain\" . }}'\n- name: PROJECT_RELEASE_VOLUME_STORAGE_CLASS\n  value: \"{{ .Values.projectReleaseVolume.storageClass }}\"\n- name: PROJECT_RELEASE_VOLUME_PERMISSION\n  value: \"{{ .Values.projectReleaseVolume.permission }}\"\n- name: APPLICATIONS_DATABASE_EXTERNAL\n  value: \"{{ .Values.applications.database.external }}\"\n{{- with .Values.applications.connectors.emailConnector.username }}\n- name: CONNECTOR_EMAILCONNECTOR_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.password }}\n- name: CONNECTOR_EMAILCONNECTOR_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.host }}\n- name: CONNECTOR_EMAILCONNECTOR_HOST\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.connectors.emailConnector.port }}\n- name: CONNECTOR_EMAILCONNECTOR_PORT\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.maxNumber }}\n- name: APPLICATIONS_MAXNUMBER\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.customRedirectUris }}\n- name: CUSTOM_REDIRECT_URIS\n  value: \"{{ . }}\"\n{{- end }}\n- name: PROCESS_STORAGE_SERVICE_CLIENTSECRET\n{{- if .Values.global.hxpr.enabled}}\n  value: \"{{ .Values.global.hxpr.admin.clientSecret }}\"\n{{- else }}\n  value: \"{{ tpl .Values.applications.processStorageService.clientSecret . }}\"\n{{- end }}\n{{- with .Values.applications.activiti.keycloak.clientId }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_ID\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n{{- with .Values.applications.activiti.keycloak.clientSecret }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_SECRET\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.port }}\n- name: APPLICATIONS_RABBITMQ_PORT\n  value: \"{{ tpl .Values.applications.rabbitmq.port . }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.host }}\n- name: APPLICATIONS_RABBITMQ_HOST\n  value: \"{{ tpl .Values.applications.rabbitmq.host . }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.ssl.enabled }}\n- name: APPLICATIONS_RABBITMQ_SSL_ENABLED\n  value: \"{{ tpl .Values.applications.rabbitmq.ssl.enabled . }}\"\n{{- end }}\n{{- with .Values.applications.rabbitmq.username }}\n- name: APPLICATIONS_RABBITMQ_USERNAME\n  value: \"{{ . }}\"\n{{- end }}\n{{- with .Values.applications.rabbitmq.password }}\n- name: APPLICATIONS_RABBITMQ_PASSWORD\n  value: \"{{ . }}\"\n{{- end }}\n{{- if .Values.applications.rabbitmq.admin.url }}\n- name: APPLICATIONS_RABBITMQ_ADMIN_URL\n  value: \"{{ tpl .Values.applications.rabbitmq.admin.url . }}\"\n{{- end }}\n- name: APPLICATIONS_ANALYTICS_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.applications.analytics.metrics.export.enabled }}\"\n{{- if .Values.applications.analytics.metrics.export.enabled }}\n- name: APPLICATIONS_ANALYTICS_METRICS_EXPORT_URL\n  value: \"{{ tpl .Values.applications.analytics.metrics.export.url $ }}\"\n- name: APPLICATIONS_ANALYTICS_METRICS_EXPORT_USERNAME\n  value: \"{{ tpl .Values.applications.analytics.metrics.export.username $ }}\"\n- name: APPLICATIONS_ANALYTICS_METRICS_EXPORT_PASSWORD\n  value: \"{{ tpl .Values.applications.analytics.metrics.export.password $ }}\"\n{{- end }}\n- name: ATS_TRANSFORMER_TIKA_URL\n  value: \"http://tika.{{ .Release.Namespace }}/transform\"\n- name: PROCESS_UI_URL\n  value: '{{ include \"common.gateway-url\" . }}'\n- name: FORCE_UPDATE_RUNTIME_VERSION\n  value: \"true\"\n{{- if .Values.global.hxpr.enabled }}\n- name: CONTENT_REPOSITORY_TYPE\n  value: \"hxp\"\n- name: PROCESS_STORAGE_SERVICE_CLIENTID\n  value: \"{{ .Values.global.hxpr.admin.clientId }}\"\n- name: HXPIDP_ACCOUNTID\n  value: \"{{ .Values.global.hxp.accountId }}\"\n- name: HXP_CONTEXT_ENVIRONMENT\n  value: \"{{ .Values.global.hxp.context.environment }}\"\n{{- end }}\n{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n- name: APPLICATIONS_DATADOG_ENABLED\n  value: \"{{ .Values.applications.datadog.enabled }}\"\n{{- if .Values.applications.datadog.enabled }}\n- name: APPLICATIONS_DATADOG_ADMISSION_ENABLED\n  value: {{ .Values.applications.datadog.agent.admission | quote }}\n{{- if .Values.applications.datadog.agent.admission }}\n- name: APPLICATIONS_DATADOG_JAVA_LIB_VERSION\n  value: {{ .Values.global.datadog.agent.javaLibVersion | required \"global.datadog.agent.javaLibVersion is required.\" | quote }}\n{{- end }}\n- name: APPLICATIONS_DATADOG_ENV\n  value: {{ tpl .Values.applications.datadog.env . | required \"applications.datadog.env is required.\" | quote }}\n{{- with .Values.global.datadog.traceAgentUrl }}\n- name: APPLICATIONS_DATADOG_TRACE_AGENT_URL\n  value: {{ . | quote }}\n{{- end }}\n- name: APPLICATIONS_DATADOG_METRICS_ENABLED\n  value: \"{{ .Values.applications.datadog.metrics.enabled }}\"\n{{- if .Values.applications.datadog.metrics.enabled }}\n- name: APPLICATIONS_DATADOG_METRICS_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: APPLICATIONS_DATADOG_METRICS_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: APPLICATIONS_DATADOG_METRICS_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: APPLICATIONS_DATADOG_METRICS_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: APPLICATIONS_DATADOG_METRICS_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: APPLICATIONS_DATADOG_METRICS_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: APPLICATIONS_DATADOG_METRICS_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: APPLICATIONS_DATADOG_METRICS_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: APPLICATIONS_DATADOG_METRICS_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n- name: APPLICATIONS_DATADOG_LOG_INJECTION_ENABLED\n  value: \"{{ .Values.applications.datadog.agent.logsInjection }}\"\n- name: APPLICATIONS_DATADOG_PROFILING_ENABLED\n  value: \"{{ .Values.applications.datadog.agent.profiling }}\"\n{{- end }}\n{{- end }}"` |  |
| alfresco-deployment-service.extraVolumes | string | `"- name: config\n  configMap:\n    name: {{ .Release.Name }}-deployment-config\n    defaultMode: 0744"` |  |
| alfresco-deployment-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-deployment-service.image.repository | string | `"quay.io/alfresco/alfresco-deployment-service"` |  |
| alfresco-deployment-service.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-deployment-service.ingress.className | string | `"nginx"` |  |
| alfresco-deployment-service.ingress.enabled | bool | `true` |  |
| alfresco-deployment-service.ingress.path | string | `"/deployment-service"` |  |
| alfresco-deployment-service.javaOpts.other | string | `"-XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true -XX:+UseZGC -XX:+ZGenerational -XX:MinHeapFreeRatio=5 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90"` |  |
| alfresco-deployment-service.javaOpts.xms | string | `"256m"` |  |
| alfresco-deployment-service.javaOpts.xmx | string | `"512m"` |  |
| alfresco-deployment-service.livenessProbe.path | string | `"{{ .Values.ingress.path }}/actuator/health/liveness"` |  |
| alfresco-deployment-service.nameOverride | string | `"alfresco-deployment-service"` |  |
| alfresco-deployment-service.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-deployment-service.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-deployment-service.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-deployment-service.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-deployment-service.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-deployment-service.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-deployment-service.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-deployment-service.postgresql.enabled | bool | `true` |  |
| alfresco-deployment-service.projectReleaseVolume.permission | string | `"ReadWriteMany"` | permission for project release volume |
| alfresco-deployment-service.projectReleaseVolume.storageClass | string | `"#{null}"` | storage class for project release volume, set to null spring expression to use default |
| alfresco-deployment-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-deployment-service.readinessProbe.path | string | `"{{ .Values.ingress.path }}/actuator/health/readiness"` |  |
| alfresco-deployment-service.replicaCount | int | `2` |  |
| alfresco-deployment-service.resources.limits.cpu | string | `"1000m"` |  |
| alfresco-deployment-service.resources.limits.memory | string | `"2525Mi"` |  |
| alfresco-deployment-service.resources.requests.cpu | string | `"300m"` |  |
| alfresco-deployment-service.resources.requests.memory | string | `"1175Mi"` |  |
| alfresco-identity-adapter-service.activiti.keycloak.clientId | string | `"{{ .Values.global.keycloak.clientId }}"` |  |
| alfresco-identity-adapter-service.activiti.keycloak.clientSecret | string | `"{{ .Values.global.keycloak.clientSecret }}"` |  |
| alfresco-identity-adapter-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-identity-adapter-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-identity-adapter-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-identity-adapter-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-identity-adapter-service.enabled | bool | `true` |  |
| alfresco-identity-adapter-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n{{- with .Values.activiti.keycloak.clientId }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_ID\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n{{- with .Values.activiti.keycloak.clientSecret }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_SECRET\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n{{- end }}"` |  |
| alfresco-identity-adapter-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-identity-adapter-service.image.repository | string | `"quay.io/alfresco/alfresco-identity-adapter-service"` |  |
| alfresco-identity-adapter-service.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-identity-adapter-service.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| alfresco-identity-adapter-service.ingress.className | string | `"nginx"` |  |
| alfresco-identity-adapter-service.ingress.enabled | bool | `true` |  |
| alfresco-identity-adapter-service.ingress.path | string | `"/identity-adapter-service/?(.*)"` |  |
| alfresco-identity-adapter-service.ingress.pathType | string | `"ImplementationSpecific"` |  |
| alfresco-identity-adapter-service.javaOpts.other | string | `"-XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true -XX:+UseZGC -XX:+ZGenerational -XX:MinHeapFreeRatio=5 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90"` |  |
| alfresco-identity-adapter-service.javaOpts.xms | string | `"512m"` |  |
| alfresco-identity-adapter-service.javaOpts.xmx | string | `"3072m"` |  |
| alfresco-identity-adapter-service.liquibase.enabled | bool | `false` |  |
| alfresco-identity-adapter-service.nameOverride | string | `"alfresco-identity-adapter-service"` |  |
| alfresco-identity-adapter-service.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-identity-adapter-service.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-identity-adapter-service.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-identity-adapter-service.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-identity-adapter-service.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-identity-adapter-service.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-identity-adapter-service.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-identity-adapter-service.postgresql.enabled | bool | `false` |  |
| alfresco-identity-adapter-service.probePath | string | `"/actuator/health"` |  |
| alfresco-identity-adapter-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-identity-adapter-service.replicaCount | int | `2` |  |
| alfresco-identity-adapter-service.resources.limits.cpu | string | `"750m"` |  |
| alfresco-identity-adapter-service.resources.limits.memory | string | `"3000Mi"` |  |
| alfresco-identity-adapter-service.resources.requests.cpu | string | `"150m"` |  |
| alfresco-identity-adapter-service.resources.requests.memory | string | `"905Mi"` |  |
| alfresco-identity-service.command[0] | string | `"/opt/keycloak/bin/kc.sh"` |  |
| alfresco-identity-service.command[1] | string | `"start"` |  |
| alfresco-identity-service.command[2] | string | `"--http-enabled=true"` |  |
| alfresco-identity-service.command[3] | string | `"--http-port=8080"` |  |
| alfresco-identity-service.command[4] | string | `"--hostname-strict=false"` |  |
| alfresco-identity-service.command[5] | string | `"--hostname-strict-https=false"` |  |
| alfresco-identity-service.command[6] | string | `"--import-realm"` |  |
| alfresco-identity-service.enabled | bool | `true` |  |
| alfresco-identity-service.extraEnv | string | `"- name: KEYCLOAK_ADMIN\n  value: admin\n- name: KEYCLOAK_ADMIN_PASSWORD\n  value: admin\n- name: JAVA_OPTS_APPEND\n  value: '-Djgroups.dns.query={{ include \"keycloak.fullname\" . }}-headless'\n- name: KC_HOSTNAME\n  value: '{{ include \"common.keycloak-host\" . }}'\n"` |  |
| alfresco-identity-service.extraInitContainers | string | `"- name: theme-download\n  args:\n    - \"-c\"\n    - |\n      wget https://github.com/Alfresco/alfresco-keycloak-theme/releases/download/0.3.5/alfresco-keycloak-theme-0.3.5.zip -O alfresco.zip\n      unzip alfresco.zip\n      mv alfresco/* /theme/\n  command:\n    - \"sh\"\n  image: \"busybox:1.36\"\n  imagePullPolicy: IfNotPresent\n  volumeMounts:\n    - name: theme\n      mountPath: /theme\n"` |  |
| alfresco-identity-service.extraVolumeMounts | string | `"- name: realm-secret\n  mountPath: /opt/keycloak/data/import\n  readOnly: true\n- name: theme\n  mountPath: /opt/keycloak/themes/alfresco\n  readOnly: true\n- name: h2-database\n  mountPath: /opt/keycloak/data/h2\n"` |  |
| alfresco-identity-service.extraVolumes | string | `"- name: realm-secret\n  secret:\n    secretName: realm-secret\n- name: theme\n  emptyDir: {}\n- name: h2-database\n  persistentVolumeClaim:\n    claimName: keycloak-pvc\n"` |  |
| alfresco-identity-service.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"16k"` |  |
| alfresco-identity-service.ingress.enabled | bool | `true` |  |
| alfresco-identity-service.ingress.ingressClassName | string | `"nginx"` |  |
| alfresco-identity-service.ingress.rules[0].host | string | `"{{ include \"common.keycloak-host\" . }}"` |  |
| alfresco-identity-service.ingress.rules[0].paths[0].path | string | `"/auth"` |  |
| alfresco-identity-service.ingress.rules[0].paths[0].pathType | string | `"Prefix"` |  |
| alfresco-identity-service.ingress.tls | list | `[]` |  |
| alfresco-identity-service.postgresql.enabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.adminPassword | string | `"admin"` |  |
| alfresco-identity-service.realm.alfresco.client.redirectUris[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.client.webOrigins[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].clientId | string | `"activiti"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[0].clientRoles | list | `[]` |  |
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
| alfresco-identity-service.realm.alfresco.extraClients[2].bearerOnly | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].clientAuthenticatorType | string | `"client-secret"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].clientId | string | `"activiti-keycloak"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].directAccessGrantsEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].fullScopeAllowed | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].implicitFlowEnabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].protocol | string | `"openid-connect"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].publicClient | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].secret | string | `"d2b835b5-efdf-4448-8d55-89eaaca9fc96"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].serviceAccountsEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[2].standardFlowEnabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].clientAuthenticatorType | string | `"client-secret"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].clientId | string | `"analytics-playground"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].directAccessGrantsEnabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].implicitFlowEnabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocol | string | `"openid-connect"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].config."access.token.claim" | string | `"true"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].config."claim.name" | string | `"role"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].config."jsonType.label" | string | `"String"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].config.multivalued | string | `"true"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].consentRequired | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].name | string | `"realm roles"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].protocol | string | `"openid-connect"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].protocolMappers[0].protocolMapper | string | `"oidc-usermodel-realm-role-mapper"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].publicClient | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].redirectUris[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].secret | string | `"2181210d-ec04-4bcf-8649-8a5dcb1c6342"` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].serviceAccountsEnabled | bool | `false` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].standardFlowEnabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraClients[3].webOrigins[0] | string | `"*"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[0].name | string | `"hr"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[0].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[1].name | string | `"sales"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[1].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[2].name | string | `"testgroup"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[3].name | string | `"processadmin"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[3].realmRoles[0] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[4].name | string | `"processanalytics"` |  |
| alfresco-identity-service.realm.alfresco.extraGroups[4].realmRoles[0] | string | `"ACTIVITI_ANALYTICS"` |  |
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
| alfresco-identity-service.realm.alfresco.extraRealmRoles[5].composites.client.realm-management[0] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[5].composites.client.realm-management[1] | string | `"view-clients"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[5].description | string | `"user is able to use analytics graphql api"` |  |
| alfresco-identity-service.realm.alfresco.extraRealmRoles[5].name | string | `"ACTIVITI_ANALYTICS"` |  |
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
| alfresco-identity-service.realm.alfresco.extraUsers[0].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].email | string | `"superadminuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].firstName | string | `"Super Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[0] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[1] | string | `"ACTIVITI_IDENTITY"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[2] | string | `"ACTIVITI_DEVOPS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[3] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[4] | string | `"ACTIVITI_MODELER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[5] | string | `"ACTIVITI_ANALYTICS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[6] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].realmRoles[7] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[0].username | string | `"superadminuser"` |  |
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
| alfresco-identity-service.realm.alfresco.extraUsers[11].clientRoles.realm-management[0] | string | `"query-realms"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[11].clientRoles.realm-management[1] | string | `"view-users"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[11].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[11].serviceAccountClientId | string | `"activiti-keycloak"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[11].username | string | `"service-account-activiti-keycloak"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].email | string | `"devopsuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].firstName | string | `"DevOps"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].realmRoles[2] | string | `"ACTIVITI_DEVOPS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[1].username | string | `"devopsuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].email | string | `"hruser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].firstName | string | `"HR"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].groups[0] | string | `"/hr"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].realmRoles[2] | string | `"ACTIVITI_USER"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[2].username | string | `"hruser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].email | string | `"processadminuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].firstName | string | `"Process Admin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].groups[0] | string | `"/processadmin"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].realmRoles[2] | string | `"ACTIVITI_ADMIN"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[3].username | string | `"processadminuser"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].clientRoles.account[0] | string | `"manage-account"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].clientRoles.account[1] | string | `"view-profile"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].credentials[0].type | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].credentials[0].value | string | `"password"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].email | string | `"processanalyticsuser@example.com"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].enabled | bool | `true` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].firstName | string | `"Process Analytics"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].groups[0] | string | `"/processanalytics"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].lastName | string | `"User"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[0] | string | `"offline_access"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[1] | string | `"uma_authorization"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].realmRoles[2] | string | `"ACTIVITI_ANALYTICS"` |  |
| alfresco-identity-service.realm.alfresco.extraUsers[4].username | string | `"processanalyticsuser"` |  |
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
| alfresco-modeling-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-modeling-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-modeling-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-modeling-app.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-modeling-app.enabled | bool | `true` |  |
| alfresco-modeling-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-modeling-app.env.APP_CONFIG_BPM_HOST | string | `"{{ include \"common.gateway-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_DISABLED_EXAMPLE_PROJECTS | string | `"{{ .Values.exampleProjects.disabled }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_ECM_HOST | string | `"{{ template \"alfresco-process-infrastructure.acs-url\" . }}"` |  |
| alfresco-modeling-app.env.APP_CONFIG_IDENTITY_HOST | string | `"{{ include \"common.keycloak-url\" . }}/admin/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-modeling-app.exampleProjects.disabled | bool | `false` |  |
| alfresco-modeling-app.image.pullPolicy | string | `"Always"` |  |
| alfresco-modeling-app.image.repository | string | `"quay.io/alfresco/alfresco-modeling-app"` |  |
| alfresco-modeling-app.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-modeling-app.ingress.annotations."nginx.ingress.kubernetes.io/cors-allow-headers" | string | `"Authorization, Content-Type, Accept"` |  |
| alfresco-modeling-app.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-modeling-app.ingress.className | string | `"nginx"` |  |
| alfresco-modeling-app.ingress.path | string | `"/modeling"` |  |
| alfresco-modeling-app.nameOverride | string | `"alfresco-modeling-app"` |  |
| alfresco-modeling-app.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-modeling-app.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-modeling-app.replicaCount | int | `2` |  |
| alfresco-modeling-app.resources.limits.cpu | string | `"500m"` |  |
| alfresco-modeling-app.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-modeling-app.resources.requests.cpu | string | `"200m"` |  |
| alfresco-modeling-app.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-modeling-app.service.envType | string | `"frontend"` |  |
| alfresco-modeling-app.service.name | string | `"modeling-app"` |  |
| alfresco-modeling-service.activiti.keycloak.clientId | string | `"{{ .Values.global.keycloak.clientId }}"` |  |
| alfresco-modeling-service.activiti.keycloak.clientSecret | string | `"{{ .Values.global.keycloak.clientSecret }}"` |  |
| alfresco-modeling-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-modeling-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-modeling-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-modeling-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-modeling-service.content.client.id | string | `""` |  |
| alfresco-modeling-service.content.client.secret | string | `""` |  |
| alfresco-modeling-service.content.service.path | string | `"alfresco"` |  |
| alfresco-modeling-service.db.password | string | `"alfresco"` |  |
| alfresco-modeling-service.db.uri | string | `"jdbc:postgresql://{{ .Release.Name }}-{{ .Values.postgresql.name }}:{{ .Values.postgresql.port }}/postgres"` |  |
| alfresco-modeling-service.db.username | string | `"alfresco"` |  |
| alfresco-modeling-service.enabled | bool | `true` |  |
| alfresco-modeling-service.exampleProjects.endpoint | string | `"http://static-resources/example-projects"` |  |
| alfresco-modeling-service.exampleProjects.resource | string | `"index_7.4.0.json"` |  |
| alfresco-modeling-service.extraEnv | string | `"- name: SERVER_PORT\n  value: \"8080\"\n- name: SERVER_USEFORWARDHEADERS\n  value: \"true\"\n- name: SERVER_TOMCAT_INTERNALPROXIES\n  value: \".*\"\n- name: MANAGEMENT_ENDPOINTS_WEB_EXPOSURE_INCLUDE\n  value: \"*\"\n- name: CONTENT_CLIENT_ID\n  value: \"{{ .Values.content.client.id }}\"\n- name: CONTENT_CLIENT_SECRET\n  value: \"{{ .Values.content.client.secret }}\"\n- name: CONTENT_SERVICE_URL\n{{- if .Values.global.hxpr.enabled}}\n  value: \"{{ .Values.global.hxpr.url }}\"\n{{- else }}\n  value: '{{ template \"alfresco-process-infrastructure.acs-url\" . }}'\n{{- end }}\n- name: CONTENT_SERVICE_PATH\n  value: \"{{ .Values.content.service.path }}\"\n- name: CONTENT_SERVICE_ENABLED\n  value: \"{{ or .Values.global.acs.enabled .Values.global.hxpr.enabled }}\"\n{{- if .Values.global.hxpr.enabled}}\n- name: CONTENT_REPOSITORY_TYPE\n  value: \"hxp\"\n- name: HXPIDP_ACCOUNTID\n  value: \"{{ .Values.global.hxp.accountId }}\"\n{{- end }}\n{{- with .Values.activiti.keycloak.clientId }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_ID\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n{{- with .Values.activiti.keycloak.clientSecret }}\n- name: ACTIVITI_KEYCLOAK_CLIENT_SECRET\n  value: \"{{ tpl . $ }}\"\n{{- end }}\n- name: ACT_ALFRESCO_MODELING_TEMPLATES_ENDPOINT\n  value: \"{{ .Values.exampleProjects.endpoint }}\"\n- name: ACT_ALFRESCO_MODELING_TEMPLATES_RESOURCE\n  value: \"{{ .Values.exampleProjects.resource }}\"\n{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n{{- end }}"` |  |
| alfresco-modeling-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-modeling-service.image.repository | string | `"quay.io/alfresco/alfresco-modeling-service"` |  |
| alfresco-modeling-service.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-modeling-service.ingress.annotations."nginx.ingress.kubernetes.io/rewrite-target" | string | `"/$1"` |  |
| alfresco-modeling-service.ingress.className | string | `"nginx"` |  |
| alfresco-modeling-service.ingress.enabled | bool | `true` |  |
| alfresco-modeling-service.ingress.path | string | `""` |  |
| alfresco-modeling-service.ingress.pathType | string | `"ImplementationSpecific"` |  |
| alfresco-modeling-service.ingress.subPaths[0] | string | `"/modeling-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[1] | string | `"/dmn-service/?(.*)"` |  |
| alfresco-modeling-service.ingress.subPaths[2] | string | `"/script-service/?(.*)"` |  |
| alfresco-modeling-service.javaOpts.other | string | `"-XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true -XX:+UseZGC -XX:+ZGenerational -XX:MinHeapFreeRatio=5 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90"` |  |
| alfresco-modeling-service.javaOpts.xms | string | `"512m"` |  |
| alfresco-modeling-service.javaOpts.xmx | string | `"1024m"` |  |
| alfresco-modeling-service.liquibase.enabled | bool | `true` |  |
| alfresco-modeling-service.nameOverride | string | `"alfresco-modeling-service"` |  |
| alfresco-modeling-service.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-modeling-service.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-modeling-service.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-modeling-service.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-modeling-service.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-modeling-service.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-modeling-service.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-modeling-service.postgresql.enabled | bool | `true` |  |
| alfresco-modeling-service.probePath | string | `"/actuator/health"` |  |
| alfresco-modeling-service.rabbitmq.enabled | bool | `false` |  |
| alfresco-modeling-service.replicaCount | int | `2` |  |
| alfresco-modeling-service.resources.limits.cpu | string | `"2500m"` |  |
| alfresco-modeling-service.resources.limits.memory | string | `"2000Mi"` |  |
| alfresco-modeling-service.resources.requests.cpu | string | `"1000m"` |  |
| alfresco-modeling-service.resources.requests.memory | string | `"1150Mi"` |  |
| alfresco-process-analytics-playground.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-process-analytics-playground.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-process-analytics-playground.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-process-analytics-playground.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-process-analytics-playground.enabled | bool | `true` |  |
| alfresco-process-analytics-playground.env.ALFRESCO_PROCESS_ANALYTICS_GRAPHQL_CLIENT_JWT_ISSUER_URI | string | `"{{ tpl .Values.graphql.client.jwtIssuerUri $ }}"` |  |
| alfresco-process-analytics-playground.env.ALFRESCO_PROCESS_ANALYTICS_GRAPHQL_CLIENT_OAUTH2_CLIENT_ID | string | `"{{ tpl .Values.graphql.client.oauth2ClientId $ }}"` |  |
| alfresco-process-analytics-playground.env.ALFRESCO_PROCESS_ANALYTICS_GRAPHQL_CLIENT_OAUTH2_CLIENT_SECRET | string | `"{{ tpl .Values.graphql.client.oauth2ClientSecret $ }}"` |  |
| alfresco-process-analytics-playground.env.ALFRESCO_PROCESS_ANALYTICS_GRAPHQL_CLIENT_URL | string | `"{{ tpl .Values.graphql.client.url $ }}"` |  |
| alfresco-process-analytics-playground.env.SPRING_WEBFLUX_BASE_PATH | string | `"{{ tpl .Values.ingress.path $ | trimSuffix \"/\" }}"` |  |
| alfresco-process-analytics-playground.env.SPRING_ZIPKIN_ENABLED | string | `"false"` |  |
| alfresco-process-analytics-playground.extraEnv | string | `"{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n{{- end }}\n"` |  |
| alfresco-process-analytics-playground.graphql.client.jwtIssuerUri | string | `"{{ include \"common.keycloak-url\" . }}/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-process-analytics-playground.graphql.client.oauth2ClientId | string | `"analytics-playground"` |  |
| alfresco-process-analytics-playground.graphql.client.oauth2ClientSecret | string | `"2181210d-ec04-4bcf-8649-8a5dcb1c6342"` |  |
| alfresco-process-analytics-playground.graphql.client.url | string | `"http://alfresco-process-analytics-service.{{ .Release.Namespace }}.svc.cluster.local/analytics/graphql"` |  |
| alfresco-process-analytics-playground.image.pullPolicy | string | `"Always"` |  |
| alfresco-process-analytics-playground.image.repository | string | `"quay.io/alfresco/alfresco-process-analytics-graphql-playground"` |  |
| alfresco-process-analytics-playground.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-process-analytics-playground.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-process-analytics-playground.ingress.className | string | `"nginx"` |  |
| alfresco-process-analytics-playground.ingress.enabled | bool | `true` |  |
| alfresco-process-analytics-playground.ingress.path | string | `"/analytics/playground/"` |  |
| alfresco-process-analytics-playground.nameOverride | string | `"alfresco-process-analytics-playground"` |  |
| alfresco-process-analytics-playground.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-process-analytics-playground.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-process-analytics-playground.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-process-analytics-playground.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-process-analytics-playground.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-process-analytics-playground.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-process-analytics-playground.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-process-analytics-playground.probePath | string | `"{{ tpl .Values.ingress.path $ | trimSuffix \"/\" }}/actuator/health"` |  |
| alfresco-process-analytics-playground.replicaCount | int | `2` |  |
| alfresco-process-analytics-playground.resources.limits.cpu | string | `"1000m"` |  |
| alfresco-process-analytics-playground.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-process-analytics-playground.resources.requests.cpu | string | `"200m"` |  |
| alfresco-process-analytics-playground.resources.requests.memory | string | `"512Mi"` |  |
| alfresco-process-analytics-playground.service.internalPort | int | `5000` |  |
| alfresco-process-analytics-playground.service.name | string | `"alfresco-process-analytics-playground"` |  |
| alfresco-process-analytics-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-process-analytics-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-process-analytics-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-process-analytics-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-process-analytics-service.enabled | bool | `true` |  |
| alfresco-process-analytics-service.env.ALFRESCO_PROCESS_ANALYTICS_GRAPHQL_SERVICE_JWT_ISSUER_URI | string | `"{{ tpl .Values.graphql.service.jwtIssuerUri $ }}"` |  |
| alfresco-process-analytics-service.env.ALFRESCO_PROCESS_ANALYTICS_METRICS_CLIENT_PASSWORD | string | `"{{ tpl .Values.metrics.client.password $ }}"` |  |
| alfresco-process-analytics-service.env.ALFRESCO_PROCESS_ANALYTICS_METRICS_CLIENT_URL | string | `"{{ tpl .Values.metrics.client.url $ }}"` |  |
| alfresco-process-analytics-service.env.ALFRESCO_PROCESS_ANALYTICS_METRICS_CLIENT_USERNAME | string | `"{{ tpl .Values.metrics.client.username $ }}"` |  |
| alfresco-process-analytics-service.env.SPRING_WEBFLUX_BASE_PATH | string | `"{{ tpl .Values.ingress.path $ | trimSuffix \"/\" }}"` |  |
| alfresco-process-analytics-service.env.SPRING_ZIPKIN_ENABLED | string | `"false"` |  |
| alfresco-process-analytics-service.extraEnv | string | `"{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n{{- end }}\n"` |  |
| alfresco-process-analytics-service.graphql.service.jwtIssuerUri | string | `"{{ include \"common.keycloak-url\" . }}/realms/{{ include \"common.keycloak-realm\" . }}"` |  |
| alfresco-process-analytics-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-process-analytics-service.image.repository | string | `"quay.io/alfresco/alfresco-process-analytics-graphql-service"` |  |
| alfresco-process-analytics-service.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-process-analytics-service.ingress.annotations."nginx.ingress.kubernetes.io/enable-cors" | string | `"true"` |  |
| alfresco-process-analytics-service.ingress.className | string | `"nginx"` |  |
| alfresco-process-analytics-service.ingress.enabled | bool | `true` |  |
| alfresco-process-analytics-service.ingress.path | string | `"/analytics"` |  |
| alfresco-process-analytics-service.metrics.client.password | string | `"admin"` |  |
| alfresco-process-analytics-service.metrics.client.url | string | `"http://opensearch-cluster-master.{{ .Release.Namespace }}.svc.cluster.local:9200"` |  |
| alfresco-process-analytics-service.metrics.client.username | string | `"admin"` |  |
| alfresco-process-analytics-service.nameOverride | string | `"alfresco-process-analytics-service"` |  |
| alfresco-process-analytics-service.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-process-analytics-service.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-process-analytics-service.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-process-analytics-service.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-process-analytics-service.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-process-analytics-service.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-process-analytics-service.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-process-analytics-service.probePath | string | `"{{ tpl .Values.ingress.path $ | trimSuffix \"/\" }}/actuator/health"` |  |
| alfresco-process-analytics-service.replicaCount | int | `2` |  |
| alfresco-process-analytics-service.resources.limits.cpu | string | `"1000m"` |  |
| alfresco-process-analytics-service.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-process-analytics-service.resources.requests.cpu | string | `"200m"` |  |
| alfresco-process-analytics-service.resources.requests.memory | string | `"512Mi"` |  |
| alfresco-process-analytics-service.service.internalPort | int | `8080` |  |
| alfresco-process-analytics-service.service.name | string | `"alfresco-process-analytics-service"` |  |
| alfresco-static-resources.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-static-resources.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-static-resources.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-static-resources.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-static-resources.enabled | bool | `true` |  |
| alfresco-static-resources.image.pullPolicy | string | `"Always"` |  |
| alfresco-static-resources.image.repository | string | `"quay.io/alfresco/apa-static-resources"` |  |
| alfresco-static-resources.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-static-resources.ingress.enabled | bool | `false` |  |
| alfresco-static-resources.livenessProbe.path | string | `"/"` |  |
| alfresco-static-resources.livenessProbe.port | int | `8080` |  |
| alfresco-static-resources.nameOverride | string | `"alfresco-static-resources"` |  |
| alfresco-static-resources.podAnnotations | string | `nil` |  |
| alfresco-static-resources.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-static-resources.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-static-resources.readinessProbe.path | string | `"/"` |  |
| alfresco-static-resources.readinessProbe.port | int | `8080` |  |
| alfresco-static-resources.replicaCount | int | `2` |  |
| alfresco-static-resources.resources.limits.cpu | string | `"500m"` |  |
| alfresco-static-resources.resources.limits.memory | string | `"128Mi"` |  |
| alfresco-static-resources.resources.requests.cpu | string | `"200m"` |  |
| alfresco-static-resources.resources.requests.memory | string | `"128Mi"` |  |
| alfresco-static-resources.service.internalPort | int | `8080` |  |
| alfresco-static-resources.service.name | string | `"static-resources"` |  |
| alfresco-tika-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/instance" | string | `"{{ .Release.Name }}"` |  |
| alfresco-tika-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchLabels."app.kubernetes.io/name" | string | `"{{ template \"common.name\" . }}"` |  |
| alfresco-tika-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"failure-domain.beta.kubernetes.io/zone"` |  |
| alfresco-tika-service.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `10` |  |
| alfresco-tika-service.enabled | bool | `true` |  |
| alfresco-tika-service.extraEnv | string | `"{{- if .Values.global.datadog.enabled }}\n{{- with .Values.global.datadog.agent.traceAgentUrl }}\n- name: DD_TRACE_AGENT_URL\n  value: {{ . }}\n{{- end }}\n{{- if not .Values.global.datadog.agent.admission }}\n- name: DATADOG_JAVA_AGENT\n  value: \"{{ .Values.global.datadog.enabled }}\"\n- name: DD_SERVICE\n  value: \"{{ .Chart.Name }}\"\n- name: DD_ENV\n  value: {{ .Values.global.datadog.env | required \"global.datadog.env is required.\" | quote }}\n- name: DD_VERSION\n  value: \"{{ .Values.image.tag }}\"\n{{- end }}\n- name: DD_LOGS_INJECTION\n  value: \"{{ .Values.global.datadog.agent.logsInjection }}\"\n- name: DD_PROFILING_ENABLED\n  value: \"{{ .Values.global.datadog.agent.profiling }}\"\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_ENABLED\n  value: \"{{ .Values.global.datadog.metrics.enabled }}\"\n{{- if .Values.global.datadog.metrics.enabled }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_API_KEY\n  value: {{ .Values.global.datadog.metrics.apiKey | required \"global.datadog.metrics.apiKey is required.\" | quote }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_DESCRIPTIONS\n  value: {{ .Values.global.datadog.metrics.descriptions | required \"global.datadog.metrics.descriptions is required.\" | quote }}\n{{- with .Values.global.datadog.metrics.applicationKey }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_APPLICATION_KEY\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.uri }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_URI\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.hostTag }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_HOST_TAG\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.step }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_STEP\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.connectTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_CONNECT_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.readTimeout }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_READ_TIMEOUT\n  value: {{ . | quote }}\n{{- end }}\n{{- with .Values.global.datadog.metrics.batchSize }}\n- name: MANAGEMENT_DATADOG_METRICS_EXPORT_BATCH_SIZE\n  value: {{ . | quote }}\n{{- end }}\n{{- end }}\n{{- end }}\n"` |  |
| alfresco-tika-service.image.pullPolicy | string | `"Always"` |  |
| alfresco-tika-service.image.repository | string | `"quay.io/alfresco/alfresco-process-tika"` |  |
| alfresco-tika-service.image.tag | string | `"7.19.0-rc.140"` |  |
| alfresco-tika-service.ingress.enabled | bool | `false` |  |
| alfresco-tika-service.javaOpts.other | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| alfresco-tika-service.livenessProbe.path | string | `"/live"` |  |
| alfresco-tika-service.nameOverride | string | `"alfresco-tika-service"` |  |
| alfresco-tika-service.podAnnotations."admission.datadoghq.com/java-lib.version" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.javaLibVersion\" . }}"` |  |
| alfresco-tika-service.podDisruptionBudget.enabled | bool | `true` |  |
| alfresco-tika-service.podDisruptionBudget.minAvailable | int | `1` |  |
| alfresco-tika-service.podLabels."admission.datadoghq.com/enabled" | string | `"{{ include \"alfresco-process-infrastructure.datadog.agent.admission\" . }}"` |  |
| alfresco-tika-service.podLabels."tags.datadoghq.com/env" | string | `"{{ include \"alfresco-process-infrastructure.datadog.env\" . }}"` |  |
| alfresco-tika-service.podLabels."tags.datadoghq.com/service" | string | `"{{ .Chart.Name }}"` |  |
| alfresco-tika-service.podLabels."tags.datadoghq.com/version" | string | `"{{ .Values.image.tag }}"` |  |
| alfresco-tika-service.readinessProbe.path | string | `"/ready"` |  |
| alfresco-tika-service.replicaCount | int | `2` |  |
| alfresco-tika-service.resources.limits.memory | string | `"1000Mi"` |  |
| alfresco-tika-service.resources.requests.memory | string | `"1000Mi"` |  |
| alfresco-tika-service.service.internalPort | int | `8090` |  |
| alfresco-tika-service.service.name | string | `"tika"` |  |
| global | object | `{"acs":{"activemq":{"password":"","url":"","username":""},"admin":{"password":"","username":""},"enabled":false,"host":"{{ template \"common.gateway-host\" . }}","url":""},"datadog":{"agent":{"admission":true,"javaLibVersion":null,"logsInjection":true,"profiling":false,"traceAgentUrl":null},"enabled":false,"env":null,"metrics":{"apiKey":null,"applicationKey":null,"batchSize":null,"connectTimeout":null,"descriptions":true,"enabled":false,"hostTag":null,"readTimeout":null,"step":null,"uri":null}},"gateway":{"annotations":{},"domain":"","host":"{{ template \"common.gateway-domain\" . }}","http":"false","tlsacme":"false"},"hxp":{"accountId":""},"hxpr":{"admin":{"clientId":"","clientSecret":""},"enabled":false},"keycloak":{"clientId":"activiti-keycloak","clientSecret":"d2b835b5-efdf-4448-8d55-89eaaca9fc96","host":"{{ template \"common.gateway-host\" . }}","realm":"alfresco","resource":"alfresco","url":""},"registryPullSecrets":["quay-registry-secret"]}` | for common values see https://github.com/Activiti/activiti-cloud-common-chart/blob/master/charts/common/README.md |
| global.acs.activemq.url | string | `""` | ACS ActiveMQ URL for events |
| global.acs.activemq.username | string | `""` | ACS ActiveMQ password |
| global.acs.admin | object | `{"password":"","username":""}` | admin credentials to setup required users/groups/acl on ACS |
| global.acs.admin.password | string | `""` | ACS admin password |
| global.acs.admin.username | string | `""` | ACS admin username |
| global.acs.enabled | bool | `false` | enable support for ACS |
| global.acs.host | string | `"{{ template \"common.gateway-host\" . }}"` | host for content services |
| global.acs.url | string | `""` | set full url to configure external ACS, https://acs.mydomain.com without /alfresco |
| global.datadog.agent.admission | bool | `true` | enables application Datadog trace agent admission webhook instrumentation for AAE infrastructure services |
| global.datadog.agent.javaLibVersion | string | `nil` | configures Datadog Java trace agent version. Required if admission is enabled |
| global.datadog.agent.logsInjection | bool | `true` | configures Datadog trace agent logs injection support for AAE services. |
| global.datadog.agent.profiling | bool | `false` | configures Datadog trace agent profiling support for AAE services. |
| global.datadog.agent.traceAgentUrl | string | `nil` | configured default Datadog trace agent url, if needed, i.e. unix:///var/run/datadog/apm.socket |
| global.datadog.enabled | bool | `false` | enables Datadog observability for AAE infrastructure and runtime application services |
| global.datadog.env | string | `nil` | configures Datadog environment tag. Required if agent or metrics enabled is true. |
| global.datadog.metrics.apiKey | string | `nil` | configures application Datadog metrics export api key. Required if metrics.enabled is true |
| global.datadog.metrics.applicationKey | string | `nil` | configures application Datadog metrics export application key if needed. |
| global.datadog.metrics.batchSize | string | `nil` | configures application Datadog metrics export batch size if needed, i.e. 10000. |
| global.datadog.metrics.connectTimeout | string | `nil` | configures application Datadog metrics export connect timeout if needed, i.e. PT1S. |
| global.datadog.metrics.descriptions | bool | `true` | enables application Datadog metrics export details. |
| global.datadog.metrics.enabled | bool | `false` | enables application Datadog metrics registry export for AAE infrastructure services. |
| global.datadog.metrics.hostTag | string | `nil` | configures application Datadog metrics export host tag property if needed, i.e. instance |
| global.datadog.metrics.readTimeout | string | `nil` | configures application Datadog metrics export read timeout if needed, i.e. PT10S. |
| global.datadog.metrics.step | string | `nil` | configures application Datadog metrics registry step interval if needed, i.e. PT1M |
| global.datadog.metrics.uri | string | `nil` | configures application Datadog metrics export uri if needed, i.e. https://api.datadoghq.com |
| global.gateway.annotations | object | `{}` | Configure global annotations for all service ingresses |
| global.gateway.domain | string | `""` | Set to configure gateway domain template, i.e. {{ .Release.Namespace }}.1.3.4.5.nip.io $ helm upgrade aae . --install --set global.gateway.domain=1.2.3.4.nip.io |
| global.gateway.host | string | `"{{ template \"common.gateway-domain\" . }}"` | Set to configure single host domain name for all services, i.e. "{{ .Release.Namespace }}.{{ template "common.gateway-domain" . }}" |
| global.gateway.http | string | `"false"` | Set to false enables HTTPS configuration on all urls |
| global.gateway.tlsacme | string | `"false"` | Set to enable automatic TLS for ingress if https is enabled |
| global.hxp.accountId | string | `""` | the HxP IAM account id which the HxP Repository belongs to |
| global.hxpr.admin | object | `{"clientId":"","clientSecret":""}` | admin credentials to manage HxP Repository models |
| global.hxpr.admin.clientId | string | `""` | HxP Repository admin client secret |
| global.hxpr.enabled | bool | `false` | enable support for HxP Repository |
| global.keycloak.clientId | string | `"activiti-keycloak"` | Configure Activiti Keycloak Client Id |
| global.keycloak.clientSecret | string | `"d2b835b5-efdf-4448-8d55-89eaaca9fc96"` | Configure Activiti Keycloak Client Secret. |
| global.keycloak.host | string | `"{{ template \"common.gateway-host\" . }}"` | Configure Keycloak host template, i.e. "{{ .Release.Namespace }}.{{ .Values.global.gateway.domain }}" |
| global.keycloak.realm | string | `"alfresco"` | Configure Keycloak realm |
| global.keycloak.resource | string | `"alfresco"` | Configure Keycloak resource |
| global.keycloak.url | string | `""` | Set full url to configure external Keycloak, https://keycloak.mydomain.com/auth |
| global.registryPullSecrets | list | `["quay-registry-secret"]` | Configure pull secrets for all deployments |
| opensearch.enabled | bool | `true` |  |
| opensearch.extraEnvs[0].name | string | `"DISABLE_INSTALL_DEMO_CONFIG"` |  |
| opensearch.extraEnvs[0].value | string | `"true"` |  |
| opensearch.extraEnvs[1].name | string | `"DISABLE_SECURITY_PLUGIN"` |  |
| opensearch.extraEnvs[1].value | string | `"true"` |  |
| opensearch.replicas | int | `2` |  |
| postgresql.auth.password | string | `"alfresco"` |  |
| postgresql.auth.username | string | `"alfresco"` |  |
| postgresql.database | string | `"postgres"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.image.tag | string | `"11.22.0"` |  |
| postgresql.persistence.mountPath | string | `"/bitnami/postgresql"` |  |
| postgresql.postgresqlDataDir | string | `"/bitnami/postgresql/data"` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 300\nlog_min_messages = LOG\n"` |  |
| postgresql.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql.resources.requests.memory | string | `"1500Mi"` |  |
| rabbitmq.auth.erlangCookie | string | `"ylY79lOdNUWsJEwAGdVQnhjSazV4QZKO="` |  |
| rabbitmq.auth.password | string | `"CHANGEME"` |  |
| rabbitmq.auth.username | string | `"user"` |  |
| rabbitmq.enabled | bool | `true` |  |
| rabbitmq.extraPlugins | string | `""` |  |
| rabbitmq.resources.limits.memory | string | `"1500Mi"` |  |
| rabbitmq.resources.requests.memory | string | `"1500Mi"` |  |
| setup-acs-script-job.enabled | bool | `true` |  |
| setup-acs-script-job.image.repository | string | `"rockylinux/rockylinux"` |  |
| setup-acs-script-job.image.tag | string | `"9-minimal"` |  |
| setup-acs-script-job.loadTestData | bool | `true` |  |
