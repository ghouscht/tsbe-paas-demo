# HelloTSBE - GKE Demo
<https://console.cloud.google.com/kubernetes>

## Create a GKE Cluster
### 1. provision Cluster
Easiest way is via WebUI open the link above and do the following: 

1. Erstellen, Standard -> Konfigurieren
2. "Mein erster Cluster" -> Jetzt erstellen

```bash
gcloud container clusters list
gcloud container clusters get-credentials my-first-cluster-1 --region us-central1-c
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


## (Re)build docker image
```bash
cat TOKEN.txt | docker login https://docker.pkg.github.com -u ghouscht --password-stdin
docker build -t docker.pkg.github.com/ghouscht/tsbe-paas-demo/hellotsbe:latest .
docker push docker.pkg.github.com/ghouscht/tsbe-paas-demo/hellotsbe:latest
```