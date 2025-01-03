#!/bin/bash

case $1 in
dev)
    bash deploy.sh catalogue dev app
    bash deploy.sh cart dev app
    bash deploy.sh user dev app
    bash deploy.sh shipping dev app
    bash deploy.sh payment dev app
    bash deploy.sh frontend dev web
    ;;
prod)
    bash deploy.sh catalogue prod app
    bash deploy.sh cart prod app
    bash deploy.sh user prod app
    bash deploy.sh shipping prod app
    bash deploy.sh payment prod app
    bash deploy.sh frontend prod web
    ;;
esac