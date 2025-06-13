# ingress-nginx

Docs: https://kubernetes.github.io/ingress-nginx/
Github Repo: https://github.com/kubernetes/ingress-nginx

```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx --force-update
helm upgrade \
  ingress-nginx ingress-nginx/ingress-nginx \
  --install \
  --namespace ingress-nginx \
  --create-namespace \
  --version 4.12.1 \
  --values values.yaml
```
