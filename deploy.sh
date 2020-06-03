docker build -t warunakanishka/multi-client:latest -t warunakanishka/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t warunakanishka/multi-server:latest -t warunakanishka/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t warunakanishka/multi-worker:latest -t warunakanishka/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push warunakanishka/multi-client:latest
docker push warunakanishka/multi-server:latest
docker push warunakanishka/multi-worker:latest
docker push warunakanishka/multi-client:$SHA
docker push warunakanishka/multi-server:$SHA
docker push warunakanishka/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=warunakanishka/multi-server:$SHA
kubectl set image deployments/worker-deployment server=warunakanishka/multi-worker:$SHA
kubectl set image deployments/client-deployment server=warunakanishka/multi-client:$SHA