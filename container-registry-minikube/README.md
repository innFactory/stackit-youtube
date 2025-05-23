# build image
```
git clone https://github.com/gabrielecirulli/2048.git ./game2048/2048
docker build -t "game2048" ./game2048
```

# push image
replace tag 1a81dac65506 with your image-id
```
docker images -a
docker tag 1a81dac65506 registry.onstackit.cloud/test-tje2e/game2048:1.0.0
docker push registry.onstackit.cloud/test-tje2e/game2048:1.0.0
```

# install minikube
`brew install minikube`
or with binary
https://minikube.sigs.k8s.io/docs/start


# kubernetes imagePullSecret
IMPORTANT escape the $ -> robot$test-tje2e+test2 -> robot\$test-tje2e+test2
```
kubectl create secret docker-registry stackit-container-reg-secret --docker-server=registry.onstackit.cloud --docker-username=robot\$test-tje2e+test2 --docker-password=GwrF77vgy1NGdyyMIvcntoAIRS62aQIy

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