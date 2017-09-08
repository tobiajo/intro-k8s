#!/bin/sh

set -euxo pipefail

minikube addons enable ingress

kubectl create -f myweb-ingress.yaml
kubectl delete -f ./
