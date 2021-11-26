docker build -t night91/multi-client:latest -t night91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t night91/multi-server:latest -t night91/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t night91/multi-worker:latest -t night91/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push night91/multi-client:latest
docker push night91/multi-server:latest
docker push night91/multi-worker:latest
docker push night91/multi-client:$SHA
docker push night91/multi-server:$SHA
docker push night91/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=night91/multi-server:$SHA
kubectl set image deployments/client-deployment client=night91/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=night91/multi-worker:$SHA
