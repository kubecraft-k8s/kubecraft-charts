{{/*
Expand the name of the kubecraft-bootstrap.
*/}}
{{- define "kubecraft.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If podinfo name contains kubecraft-bootstrap name it will be used as a full name.
*/}}
{{- define "kubecraft.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create kubecraft-bootstrap name and version as used by the kubecraft-bootstrap label.
*/}}
{{- define "kubecraft.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kubecraft.labels" -}}
helm.sh/chart: {{ include "kubecraft.chart" . }}
{{ include "kubecraft.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
x.velero.backup: {{ .Values.backup.name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kubecraft.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kubecraft.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}