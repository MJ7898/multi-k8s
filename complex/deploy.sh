docker build -t mijenne/multi-client-k8s:latest -t mijenne/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t mijenne/multi-server-k8s:latest -t mijenne/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t mijenne/multi-worker-k8s:latest -t mijenne/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push mijenne/multi-client-k8s:latest
docker push mijenne/multi-server-k8s:latest
docker push mijenne/multi-worker-k8s:latest

docker push mijenne/multi-client-k8s:$SHA
docker push mijenne/multi-server-k8s:$SHA
docker push mijenne/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mijenne/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=mijenne/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=mijenne/multi-worker-k8s:$SHA