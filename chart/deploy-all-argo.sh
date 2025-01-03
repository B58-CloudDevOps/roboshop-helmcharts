#!/bin/bash

case $1 in
dev)
    bash deploy-argo.sh catalogue dev app
    bash deploy-argo.sh cart dev app
    bash deploy-argo.sh user dev app
    bash deploy-argo.sh shipping dev app
    bash deploy-argo.sh payment dev app
    bash deploy-argo.sh frontend dev web
    ;;
prod)
    bash deploy-argo.sh catalogue prod app
    bash deploy-argo.sh cart prod app
    bash deploy-argo.sh user prod app
    bash deploy-argo.sh shipping prod app
    bash deploy-argo.sh payment prod app
    bash deploy-argo.sh frontend prod web
    ;;
esac