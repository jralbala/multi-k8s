docker build -t jralbala/multi-client:latest -t jralbala/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jralbala/multi-server:latest -t jralbala/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jralbala/multi-worker:latest -t jralbala/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jralbala/multi-client:latest
docker push jralbala/multi-server:latest
docker push jralbala/multi-worker:latest

docker push jralbala/multi-client:$SHA
docker push jralbala/multi-server:$SHA
docker push jralbala/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jralbala/multi-server:$SHA
kubectl set image deployments/client-deployment client=jralbala/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jralbala/multi-worker:$SHA