#!/bin/sh

set -euxo pipefail

kubectl create -f webserver.yaml
kubectl get replicasets
kubectl get pods

kubectl create -f webserver-svc.yaml
kubectl get service
kubectl describe svc web-service

minikube ip

kubectl delete -f ./
