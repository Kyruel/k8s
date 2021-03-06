docker build -t kyruel/multi-client-k8s:latest -t kyruel/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t kyruel/multi-server-k8s-pgfix:latest -t kyruel/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t kyruel/multi-worker-k8s:latest -t kyruel/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push kyruel/multi-client-k8s:latest
docker push kyruel/multi-server-k8s-pgfix:latest
docker push kyruel/multi-worker-k8s:latest

docker push kyruel/multi-client-k8s:$SHA
docker push kyruel/multi-server-k8s-pgfix:$SHA
docker push kyruel/multi-worker-k8s:$SHA

kubectl apply -f simplek8s
kubectl set image deployments/server-deployment server=kyruel/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=kyruel/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=kyruel/multi-worker-k8s:$SHA