#!/bin/bash

# Create a ConfigMap with our ENV VARS. Be sure to edit the .env file first
kubectl create configmap timedb-config --from-env-file=.env

# Set up perrsistent volumes for the postgres DB
kubectl apply -f timedb-pv.yaml
kubectl get pv timedb-volume
kubectl apply -f timedb-pvc.yaml
kubectl get pv timedb-volume
kubectl get pvc timedb-pv-claim

# Create the Timedb deployment
kubectl apply -f timedb-deployment.yaml
kubectl get deployments,services,pods --show-labels=true

# If things go awry, delete everything with
# kubectl delete deployment -l app=timedb

# To see pod logs, use:
kubectl logs pod/timescaledb-575d984dcd-4dmwf

# To connect to a shell in a pod, use:
kubectl exec pod/timescaledb-575d984dcd-4dmwf -i -t -- bash
