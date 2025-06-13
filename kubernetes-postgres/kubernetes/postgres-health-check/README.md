# Build container and push it to registry
`docker build -t postgres-health-check . --platform=linux/amd64`
`docker login registry.onstackit.cloud`
`docker images -a`
`docker tag 7bb5cc254c2c registry.onstackit.cloud/kubernetes-playground/postgres-health-check:1.0.0`
`docker push registry.onstackit.cloud/kubernetes-playground/postgres-health-check:1.0.0`
