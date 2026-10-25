# Rook Ceph on gpmcluster

### Installation
- Add helm repo
```bash
helm repo add rook https://charts.rook.io/release
```

- Install the rook-ceph
```bash
helm install rook-ceph rook/rook-ceph --version 1.21.0 --namespace rook-ceph --create-namespace
```

- Apply the [rook/cluster.yaml](./rook/cluster.yaml) manifest. This will deploy solely on gpmrke2workerstor1 and gpmrke2workerstor2 only for OSD detection!
```bash
kubectl apply -f rook/cluster.yaml
```

- Apply the [rook/storageclass.yaml](./rook/storageclass.yaml) manifest for creating ceph RBD pool.
```bash
kubectl apply -f rook/cluster.yaml
```

- Apply the [rook/storageclass-cephfs.yaml](./rook/storageclass-cephfs.yaml) manifest for creating cephfs pool.
```bash
kubectl apply -f rook/cluster.yaml
```

- Finally, apply the [rook/rook-gateway.yaml](./rook/rook-gateway.yaml) manifest for creating entrypoint for rook dashboard.
```bash
kubectl apply -f rook/cluster.yaml
```