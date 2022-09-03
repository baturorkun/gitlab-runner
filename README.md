# Gitlab Runner for All Kubernetes

Tested on Openshift, RKE, RKE2 and Microk8s

### Example Usage: ( install.sh )


```
#!/usr/bin/env bash

NAMESPACE="gitlab-runner"
CLUSTER=$(kubectl cluster-info dump | grep openshift)

kubectl create namespace gitlab-runner

if [[ "$CLUSTER" != "" ]]; then  # K8S = Openshift
    oc adm policy add-scc-to-user anyuid -z gitlab-admin
    oc adm policy add-scc-to-user privileged -z gitlab-admin
fi

helm upgrade --install  --create-namespace --namespace "${NAMESPACE}" gitlab-runner-remiks  ./helm \
  --set gitlabURL="https://gitlab.mycompany" \
  --set gitlabToken="8evRPwiYHx9786qGH4Pa" \
  --set tagList='myprj\, build\, backend\, frontend\, test\, e2e' \
  --set description="RKE.local - "$(date +%F_%T) \
  --set concurrent="20"

```

### Notes:

Some of you may say that there are operators in Openshift and Rancher and wonder why not I use them, but they must know that I have used them for 2 years. Sometimes after upgrading, the operator crashed and there are some bugs.

I suggest using your Helm and controlling everything.