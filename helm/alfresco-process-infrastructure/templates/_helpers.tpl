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
{{- $defaultValue := printf "%s://%s" (include "common.gateway-proto" .) (include "alfresco-process-infrastructure.acs-host" .) -}}
{{- $value := default $defaultValue .Values.global.acs.url -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.datadog.agent.admission" -}}
{{- and .Values.global.datadog.enabled .Values.global.datadog.agent.admission -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.datadog.agent.javaLibVersion" -}}
{{- $javaLibVersion := .Values.global.datadog.agent.javaLibVersion -}}
{{- if and .Values.global.datadog.enabled .Values.global.datadog.agent.admission -}}
{{- $javaLibVersion | required "global.datadog.agent.javaLibVersion is required" -}}
{{- else -}}
{{- $javaLibVersion -}}
{{- end -}}
{{- end -}}

{{- define "alfresco-process-infrastructure.datadog.env" -}}
{{- $env := .Values.global.datadog.env -}}
{{- if .Values.global.datadog.enabled -}}
{{- $env | required "global.datadog.env is required" -}}
{{- else -}}
{{- $env -}}
{{- end -}}
{{- end -}}
