docker build -t herederpharao/multi-client:latest -t herederpharao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t herederpharao/multi-server:latest -t herederpharao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t herederpharao/multi-worker:latest -t herederpharao/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push herederpharao/multi-client:latest
docker push herederpharao/multi-server:latest
docker push herederpharao/multi-worker:latest

docker push herederpharao/multi-client:$SHA
docker push herederpharao/multi-server:$SHA
docker push herederpharao/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=herederpharao/multi-server:$SHA
kubectl set image deployments/client-deployment client=herederpharao/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=herederpharao/multi-worker:$SHA