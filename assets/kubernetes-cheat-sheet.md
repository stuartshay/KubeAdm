# Kubernetes 

## Minikube

```
minikube version
minikube start

minikube delete
```





```
kubectl cluster-info

kubectl get - list resources
kubectl get nodes
kubectl get pods -o wide ( json, yaml)


kubectl describe - show detailed information about a resource
kubectl describe pods

kubectl logs $POD_NAME - print the logs from a container in a pod

kubectl exec - execute a command on a container in a pod
kubectl exec -it $POD_NAME bash

```

### Kubeapps
https://github.com/kubeapps/kubeapps/releases






#### Deployment
```
kubectl run kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --port=8080

kubectl get deployments
```

```
kubectl proxy
```

#### Services 









### Installation

#### kubectl

Linux

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl
```
Windows 

Add minikube to Windows Path

```
cd minikube
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.10.0/bin/windows/amd64/kubectl.exe

```

```
kubectl version --output=yaml
```

#### Minikube

https://github.com/kubernetes/minikube/releases   
rename to minikube-windows-amd64 => minikube.exe

``` 
minikube version
minikube start 
```





### Start 
```
.\minikube.exe start 
.\minikube.exe start --kubernetes-version="v1.6.0" --vm-driver="virtualbox" --show-libmachine-logs --alsologtostderr
```

## Database

Image: stuartshay/navigator-identity-sqlserver:2017-CU5

```bash
kubectl run database --image=stuartshay/navigator-identity-sqlserver:2017-CU5 --port=1433
kubectl expose deployment database --type="NodePort"

kubectl describe service database

```

### Scale
kubectl scale deployment database --replicas=2

