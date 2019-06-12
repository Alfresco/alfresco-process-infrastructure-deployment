{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "alfresco-process-infrastructure.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "alfresco-process-infrastructure.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alfresco-process-infrastructure.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.keycloak-host" -}}
{{- $value := default (include "common.gateway-host" .) .Values.global.keycloak.host -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.keycloak-url" -}}
{{ template "common.gateway-proto" . }}://{{ template "alfresco-process-infrastructure.keycloak-host" . }}{{ template "common.keycloak-path" . }}
{{- end -}}

{{- define "alfresco-process-infrastructure.acs-host" -}}
{{- $value := default (include "common.gateway-host" .) .Values.global.acs.host -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.acs-url" -}}
{{ template "common.gateway-proto" . }}://{{ template "alfresco-process-infrastructure.acs-host" . }}
{{- end -}}

{{- define "alfresco-process-infrastructure.ads-registry-secret" }}
{{- $values := index .Values "alfresco-deployment-service" -}}
{{- $registry := $values.dockerRegistry.server -}}
{{- $username := $values.dockerRegistry.userName -}}
{{- $password := $values.dockerRegistry.password -}}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" $registry (printf "%s:%s" $username $password | b64enc) | b64enc }}
{{- end }}