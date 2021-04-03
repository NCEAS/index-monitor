#!/bin/bash

# Create a ConfigMap with our ENV VARS. Be sure to edit the .env file first
kubectl create configmap timedb-config --from-env-file=.env

kubectl apply -f timedb-deployment.yaml
kubectl get deployments,services,pods --show-labels=true

# If things go awry, delete everything with
# kubectl delete deployment -l app=timedb

# To see pod logs, use:
kubectl logs pod/timescaledb-575d984dcd-4dmwf

# To connect to a shell in a pod, use:
kubectl exec pod/timescaledb-575d984dcd-4dmwf -i -t bash
