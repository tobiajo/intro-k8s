#!/bin/sh

set -euxo pipefail

kubectl config view
kubectl cluster-info

kubectl proxy &
proxy_pid=$!
curl http://localhost:8001/
kill -9 $proxy_pid

token=$(kubectl describe secret $(kubectl get secrets | grep default | cut -f1 -d ' ') | grep -E '^token' | cut -f2 -d':' | tr -d '\t')
apiserver=$(kubectl config view | grep https | cut -f 2- -d ":" | tr -d " ")
curl $apiserver --header "Authorization: Bearer $token" --insecure
