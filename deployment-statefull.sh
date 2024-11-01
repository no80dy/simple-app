#!/bin/bash

kubectl apply -f $(pwd)/deployment-statefull/storageclasses.yaml
kubectl apply -f $(pwd)/deployment-statefull/persistentvolumes.yaml
kubectl apply -f $(pwd)/deployment-statefull/persistentvolumeclaimes.yaml

minikube ssh
mkdir -r /statefull/postgresql
helm repo add bitnami https://charts.bitnami.com/bitnami

helm install statefull-postgresql bitnami/postgresql --set primary.persistence.existingClaim=statefull-postgresql-persistentvolumeclaim,auth.postgresPassword=pgpass

kubectl port-forward --namespace default svc/statefull-postgresql 5432:5432
