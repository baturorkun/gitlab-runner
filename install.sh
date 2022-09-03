#!/usr/bin/env bash

NAMESPACE="gitlab-runner"
CLUSTER=$(kubectl cluster-info dump | grep openshift)

kubectl create namespace gitlab-runner

if [[ "$CLUSTER" != "" ]]; then  # K8S = Openshift
    oc adm policy add-scc-to-user anyuid -z gitlab-admin
    oc adm policy add-scc-to-user privileged -z gitlab-admin
fi

helm upgrade --install  --create-namespace --namespace "${NAMESPACE}" gitlab-runner-remiks  ./helm \
  --set gitlabURL="https://gitlab.mycompany.com" \
  --set gitlabToken="8evRPwiYHx9786qGH4Pa" \
  --set tagList='myprj\, build\, backend\, frontend\, test\, e2e' \
  --set description="RKE.local - "$(date +%F_%T) \
  --set concurrent="20"


