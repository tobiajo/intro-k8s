#!/bin/sh

set -euxo pipefail

kubectl create configmap my-config --from-literal=key1=value1 --from-literal=key2=value2
kubectl get configmaps my-config -o yaml
kubectl delete configmap my-config

printf 'mysqlpassword' > password.txt
kubectl create secret generic my-password --from-file=password.txt
kubectl get secret my-password
kubectl describe secret my-password
cat password.txt | base64
# apiVersion: v1
# kind: Secret
# metadata:
#   name: my-password
# type: Opaque
# data:
#   password: bXlzcWxwYXN3b3JkCg==
echo "bXlzcWxwYXN3b3JkCg==" | base64 --decode
#          spec:
#       containers:
#       - image: wordpress:4.7.3-apache
#         name: wordpress
#         env:
#         - name: WORDPRESS_DB_HOST
#           value: wordpress-mysql
#         - name: WORDPRESS_DB_PASSWORD
#           valueFrom:
#             secretKeyRef:
#               name: my-password
#               key: password.txt
rm password.txt
kubectl delete secret my-password

kubectl create -f customer1-configmap.yaml
kubectl create -f rsvp-web.yaml
kubectl delete -f ./
