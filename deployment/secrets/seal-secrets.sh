#!/bin/bash

usage() {
  echo "USAGE: ./seal-secrets.sh <SERVICE_NAME> <NAMESPACE>"
  echo ""
  echo "ARGS:"
  echo "Example:
  ./seal-secrets.sh node-svc development
  ./seal-secrets.sh node-svc staging
  ./seal-secrets.sh node-svc production
  "
  exit 0
}

if [ "${#@}" -lt "2" ] || [ "${#@}" -gt "3" ]; then
  usage
fi

SERVICE_NAME=${1}
NAMESPACE=${2}

kubectl create secret generic ${SERVICE_NAME}-secrets -n ${NAMESPACE} --dry-run --from-env-file=./.${NAMESPACE}.env -o json | kubeseal --controller-name kubeseal-sealed-secrets --format json > ./${SERVICE_NAME}-secrets.${NAMESPACE}.json