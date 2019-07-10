#!/bin/bash

usage() {
  echo "USAGE: ./seal-secrets.sh <SERVICE_NAME> <ENVIRONMENT>"
  echo ""
  echo "ARGS:"
  echo "Example:
  ./seal-secrets.sh users-svc dev
  ./seal-secrets.sh photos-svc uat
  ./seal-secrets.sh users staging
  ./seal-secrets.sh users prod
  "
  exit 0
}

if [ "${#@}" -lt "2" ] || [ "${#@}" -gt "3" ]; then
  usage
fi

SERVICE_NAME=${1}
ENVIRONMENT=${2}

if [[ "$ENVIRONMENT" == "dev" ]]; then
	NAMESPACE="canon-dev"
elif [[ "$ENVIRONMENT" == "uat" ]]; then
	NAMESPACE="canon-uat"
elif [[ "$ENVIRONMENT" == "staging" ]]; then
	NAMESPACE="canon-staging"
elif [[ "$ENVIRONMENT" == "prod" ]]; then
	NAMESPACE="canon-prod"
fi

kubectl create secret generic ${SERVICE_NAME}-secrets -n ${NAMESPACE} --dry-run --from-env-file=./.${ENVIRONMENT}.env -o json | kubeseal --controller-name kubeseal-sealed-secrets --format json > ./${SERVICE_NAME}-secrets.${ENVIRONMENT}.json