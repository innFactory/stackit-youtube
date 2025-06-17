# Kubernetes

## Setup SKE Cluster
Follow the instructions in ../terraform before continue here

## Connect to SKE Cluster
`stackit ske cluster list`
### Add Cluster to kubeconfig
### --login ensures that authentication is performed with the stackit CLI and very short-lived credentials are used in the background, without this flag the credentials are static and and usually have a longer lifetime. If the credentials are obtained without the `--login` flag, they must be renewed manually.
`stackit ske kubeconfig create my-ske --login`
### set kubectl context
`kubectl config use-context my-ske`

## Secret for Container Registry
Create Robot-Account `https://registry.onstackit.cloud` in `kubernetes-playground` with `pull` rights and create secret:
!Important Escape $ in docker-username
`kubectl create secret docker-registry stackit-container-reg-secret --docker-server=registry.onstackit.cloud --docker-username=robot\$kubernetes-playground+pull-push --docker-password=tbFWNKANoP1CbiV2BMcA72cLPo35ue8o`

## Deployment
```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx --force-update
helm upgrade \
  ingress-nginx ingress-nginx/ingress-nginx \
  --install \
  --namespace ingress-nginx \
  --create-namespace \
  --version 4.12.1
```

`kubectl apply -f k8s-deployment.yml`