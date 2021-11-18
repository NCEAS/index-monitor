#!/bin/bash

# Create a ConfigMap with our ENV VARS. Be sure to edit the .env file first
kubectl create configmap timedb-config --from-env-file=env
kubectl get configmap timedb-config -o yaml

# Add any files to be mounted in the volume to another ConfigMap
kubectl create configmap timedb-files --from-file config
kubectl get configmap timedb-files -o yaml
#kubectl delete configmap timedb-files

# Set up perrsistent volumes for the postgres DB
kubectl apply -f timedb-pv.yaml
#kubectl patch pv timedb-volume -p '{"spec":{"persistentVolumeReclaimPolicy":"Delete"}}'
kubectl get pv timedb-volume
kubectl apply -f timedb-pvc.yaml
kubectl get pv timedb-volume
kubectl get pvc timedb-pv-claim

# Create the Timedb deployment and associated service
kubectl apply -f timedb-deployment.yaml
kubectl create -f timedb-service.yaml
kubectl get deployments,services,pods --show-labels=true

# Create the cronjob that queries the index and updates the monitor
kubectl create -f timedb-cron.yaml
#kubectl delete cronjob timedb-cron

# Monitor when cronjobs are created and completed
kubectl get jobs --watch

# Look at logs from specific cronjob (change name of cronjob based on watch output)
pods=$(kubectl get pods --selector=job-name=timedb-cron-27285552 --output=jsonpath={.items[*].metadata.name})
kubectl logs $pods

# If things go awry, delete everything with
# kubectl delete deployment -l app=timedb

# To see pod logs, use:
kubectl logs pod/timescaledb-575d984dcd-4dmwf

# To connect to a shell in a pod, use:
kubectl exec pod/timescaledb-575d984dcd-4dmwf -i -t -- bash
