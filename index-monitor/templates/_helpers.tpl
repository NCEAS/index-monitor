{{/* Generate basic labels */}}
{{- define "index-monitor.labels" }}
  labels:
    app.kubernetes.io/name: {{ .Chart.Name }}
    app.kubernetes.io/instance: {{ .Chart.Name }}-{{ .Release.Name }}
    app.kubernetes.io/version: "{{ .Chart.Version }}"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: index-monitor
    date: {{ now | htmlDate }}
{{- end }}
