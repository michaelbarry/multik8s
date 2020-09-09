docker build -t mikebarry/multi-client:latest -t mikebarry/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mikebarry/multi-server:latest -t mikebarry/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t mikebarry/multi-worker:latest -t mikebarry/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mikebarry/multi-client:latest
docker push mikebarry/multi-client:$SHA
docker push mikebarry/multi-server:latest
docker push mikebarry/multi-server:$SHA
docker push mikebarry/multi-worker:latest
docker push mikebarry/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mikebarry/multi-server:$SHA
kubectl set image deployments/client-deployment server=mikebarry/multi-client:$SHA
kubectl set image deployments/worker-deployment server=mikebarry/multi-worker:$SHA
