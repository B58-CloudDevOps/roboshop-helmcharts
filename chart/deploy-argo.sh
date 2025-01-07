#!/bin/bash
if [ -z "$1" ]; then
  echo APP_NAME input is missing
  echo Usage: $0 APP_NAME ENV NAMESPACE
  exit 1
else
  APP_NAME=$1
fi

if [ -z "$2" ]; then
  echo ENV input is missing
  echo Usage: $0 APP_NAME ENV NAMESPACE
  exit 1
else
  ENV=$2
fi

if [ -z "$3" ]; then
  echo NAMESPACE input is missing
  echo Usage: $0 APP_NAME ENV NAMESPACE
  exit 1
else
  NAMESPACE=$3
fi

ARGOCD_PASSWORD=$(kubectl get secrets argocd-initial-admin-secret -n argocd  -o=jsonpath='{.data.password}' | base64 --decode)
argocd login  argocd.cloudapps.today:443 --grpc-web --username admin --password ${ARGOCD_PASSWORD}

argocd app list | grep argocd/$APP_NAME &>/dev/null
if [ $? -eq 0 ]; then
  argocd app sync ${APP_NAME}
  exit
fi

kubectl create ns $NAMESPACE || true
argocd app create roboshop-${APP_NAME} --project default --sync-policy auto --repo https://github.com/b58-clouddevops/roboshop-helmcharts --path chart --dest-namespace ${NAMESPACE} --dest-server https://kubernetes.default.svc --values ../env-${ENV}/${APP_NAME}.yaml