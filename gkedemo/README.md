# HelloTSBE - GKE Demo
<https://console.cloud.google.com/kubernetes>

## (Re)build and publish docker image
```bash
cat TOKEN.txt | docker login -u ghouscht --password-stdin
docker build -t ghouscht/tsbe-paas-demo:latest .
docker push ghouscht/tsbe-paas-demo:latest
```

## Create a GKE Cluster
### 1. provision Cluster
```bash
gcloud container clusters create my-first-cluster-1 --region europe-west6-a --disk-size 32G --num-nodes 3  --release-channel rapid
gcloud container clusters list
gcloud container clusters get-credentials my-first-cluster-1 --region europe-west6-a
```

### 2. test if cluster works
```bash
kubectl get node
kubectl get pod --all-namespaces
```

### 3. deploy the HelloTSBE sample
```
kubectl apply -f deployment.yaml
kubectl ns hello-tsbe
kubectl get all
```

### 4. Test
```
SERVICE_IP=$(kubectl get svc hello-tsbe -ojsonpath="{.status.loadBalancer.ingress[0].ip}")
curl http://$SERVICE_IP/
curl -X POST -d '{"name":"Thomas"}' http://$SERVICE_IP/
```

### 5. Cleanup
```bash
gcloud container clusters delete my-first-cluster-1 --region europe-west6-a
```

## Questions
* Kann das go Programm auch lokal auf dem PC ausgeführt werden (sofern ein go Compiler installiert ist)? Warum?
* Was passiert nach dem Ende des http Requests (curl bzw. Aufrug mit dem Browser) mit den Containern?
* Wo sind die grossen Unterschiede zur FaaS Lösung mit Google Cloud Functions?