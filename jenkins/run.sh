#!/usr/bin/env bash
#
# Run helper script
# Version: 1.0

set -eo pipefail
IFS=$'\n\t'

function main() {
    case "$1" in
    up)    up ;;
    down)  down ;;
    pause) pause ;;
    *) echo "Usage: $0 {up|down|pause}" ;;
    esac
}

function up() {
    kubectl apply -f resources/namespace.yaml
    kubectl apply -f resources/volume.yaml
    kubectl apply -f resources/service.yaml
    kubectl apply -f resources/deployment.yaml
}

function down() {
    kubectl delete -f resources/namespace.yaml
    kubectl delete -f resources/volume.yaml
    kubectl delete -f resources/service.yaml
    kubectl delete -f resources/deployment.yaml
}

function pause() {
    kubectl delete -f resources/service.yaml
    kubectl delete -f resources/deployment.yaml
}

main $@
