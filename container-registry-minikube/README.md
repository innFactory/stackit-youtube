# build image
```
git clone https://github.com/gabrielecirulli/2048.git ./game2048/2048
docker build -t "game2048" ./game2048
```

# push image
replace tag b1f0ff0958d1 with your image-id
```
docker images -a
docker login registry.onstackit.cloud
docker tag b1f0ff0958d1 registry.onstackit.cloud/test-wer45/game2048:1.0.0
docker push registry.onstackit.cloud/test-wer45/game2048:1.0.0
```

# install minikube
`brew install minikube`
or with binary
https://minikube.sigs.k8s.io/docs/start


# kubernetes imagePullSecret
IMPORTANT escape the $ -> robot$test-tje2e+test2 -> robot\$test-tje2e+test2
```
kubectl create secret docker-registry stackit-container-reg-secret --docker-server=registry.onstackit.cloud --docker-username=robot\$test-wer45+push-pull --docker-password=JaTH1Ap4tNe0xvlFU3HFNbIVrDjc8ldS
```

# minikube deployment

```
minikube start
kubectl apply -f deployment.yml
kubectl apply -f service.yml
```

### This command will open 2048 game on your browser
```
minikube service game2048
```