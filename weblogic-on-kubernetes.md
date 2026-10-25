# Experiment: Weblogic on Kubernetes

### Installation
- Create necessary resources (namespace and service account)
```bash
kubectl create ns weblogic-operator
kubectl create sa -n weblogic-operator weblogic-operator
```

- Add Helm repo
```bash
helm repo add weblogic-operator https://oracle.github.io/weblogic-kubernetes-operator/charts --force-update
```

- Install Weblogic Operator
```bash
helm install weblogic-operator weblogic-operator/weblogic-operator \
  --namespace weblogic-operator \
  --set serviceAccount=weblogic-operator \
  --wait
```

- Apply weblogic gateway [weblogic-operator/weblogic-gateway.yaml](./weblogic-operator/weblogic-gateway.yaml) (requires istio to be installed)
```bash
kubectl apply -f weblogic-operator/weblogic-gateway.yaml
```

### Creating Example Weblogic Domain
- Create namespace and labels
```bash
kubectl create ns ngopi-gpmsystem-ns
kubectl label ns ngopi-gpmsystem-ns weblogic-operator=enabled
kubectl label ns ngopi-gpmsystem-ns app=weblogic
```
- Add Registry Credential for pulling image
```bash
kubectl create secret docker-registry weblogic-repo-credentials \
     --docker-server=container-registry.oracle.com \
     --docker-username=YOUR_REGISTRY_USERNAME \
     --docker-password=YOUR_REGISTRY_SSO_TOKEN \
     --docker-email=YOUR_REGISTRY_EMAIL \
     -n ngopi-gpmsystem-ns
```

- Add admin secret (example). Should be minimum 8 characters with min one Uppercase, Number, and non-alphabetical character
```bash
kubectl create secret generic ngopi-gpmsystem-weblogic-credentials \
  --from-literal=username=admin --from-literal=password=Ng0picoy# \
  -n ngopi-gpmsystem-ns
```

- Create a domain runtime encryption secret for the domain 
```bash
kubectl -n ngopi-gpmsystem-ns create secret generic \
  ngopi-gpmsystem-runtime-encryption-secret \
   --from-literal=password=ngopicoy_runtime
```

- Then, create an auxiliary image by following this [Documentation](https://oracle.github.io/weblogic-kubernetes-operator/quickstart/summary/index.html#advanced-do-it-yourself).

- Finally, apply the domain configuration on [weblogic-operator/ngopi-gpmsystem-domain.yaml](./weblogic-operator/ngopi-gpmsystem-domain.yaml):
```bash
kubectl apply -f weblogic-operator/ngopi-gpmsystem-domain.yaml
```

### Monitoring

- Check the pod and svc
```bash
kubectl get pod,svc -n ngopi-gpmsystem-ns
```

### Accessing web:
- Open the service URL:
```bash
http://192.168.103.101:31080/quickstart
```

- Open the Admin Console URL:
```bash
http://192.168.103.101:31080/console
```