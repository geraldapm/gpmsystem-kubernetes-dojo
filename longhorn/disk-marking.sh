#!/bin/bash

for node in $(kubectl get node | grep worker | awk '{print $1}'); do kubectl patch nodes.longhorn.io -n longhorn-system $i --type merge -p '{
    "spec": {
      "disks": {
        "longhorndisk1": {
          "allowScheduling": true,
          "diskType": "filesystem",
          "evictionRequested": false,
          "path": "/var/mnt/longhorndisk1",
          "storageReserved": 0,
          "tags": ["externaldisk"]
        },
        "longhorndisk2": {
          "allowScheduling": true,
          "diskType": "filesystem",
          "evictionRequested": false,
          "path": "/var/mnt/longhorndisk2",
          "storageReserved": 0,
          "tags": ["externaldisk"]
        }
      }
    }
  }'; done