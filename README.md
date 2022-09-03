# Gitlab Runner for Kubernetes

Tested on Openshift, RKE, RKE2 and Microk8s


### Install from Remote

```
helm repo add gitlab-runner https://baturorkun.github.io/gitlab-runner/
helm repo update
helm install gitlab-runner  gitlab-runner/gitlab-runner \
  --set gitlabURL="https://gitlab.mycompany" \
  --set gitlabToken="XXXXXXXXXXX" \
  --set tagList='myprj\, build\, backend\, frontend\, test\, e2e' \
  --set description="RKE.local - "$(date +%F_%T) \
  --set concurrent="20"
```

### Install from Local

Clone this repository to local and edit install.sh, then Run install.sh


```
#!/usr/bin/env bash

NAMESPACE="gitlab-runner"
CLUSTER=$(kubectl cluster-info dump | grep openshift)

kubectl create namespace gitlab-runner

if [[ "$CLUSTER" != "" ]]; then  # K8S = Openshift
    oc adm policy add-scc-to-user anyuid -z gitlab-admin
    oc adm policy add-scc-to-user privileged -z gitlab-admin
fi

helm upgrade --install  --create-namespace --namespace "${NAMESPACE}" gitlab-runner  ./helm \
  --set gitlabURL="https://gitlab.mycompany" \
  --set gitlabToken="XXXXXXXXXXXXXX" \
  --set tagList='myprj\, build\, backend\, frontend\, test\, e2e' \
  --set description="RKE.local - "$(date +%F_%T) \
  --set concurrent="20"

```

### Uninstall

helm unistall gitlab-runner


### Notes:

Some of you may say that there are operators in Openshift and Rancher and wonder why not I use them, but they must know that I have used them for 2 years. Sometimes after upgrading, the operator crashed and there are some bugs.

I suggest using your Helm and controlling everything.
