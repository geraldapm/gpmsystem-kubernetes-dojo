#!/bin/bash

### Define IP Subnet for CIDR assignment including floating IP and gateway IP

IP_SUBNET=192.168.104.0/24

### Set IP Subnet Gateway
IP_GATEWAY="$(echo $IP_SUBNET | cut -d. -f1-3).1"

### Define the Virtual IP or Floating IP
IP_FLOATING="$(echo $IP_SUBNET | cut -d. -f1-3).99"

### Define cluster member list
### Ensure that the hostname has "wontrol" and "worker" inside for node role filtering
# hostlist=$(cat <<EOF
# 192.168.103.101     gpmrke2controlplane1
# 192.168.103.102     gpmrke2controlplane2
# 192.168.103.103     gpmrke2controlplane3
# 192.168.103.104     gpmrke2worker1
# 192.168.103.105     gpmrke2worker2
# 192.168.103.106     gpmrke2workergw1
# 192.168.103.107     gpmrke2workergw2
# 192.168.103.108     gpmrke2workerstor1
# 192.168.103.109     gpmrke2workerstor2
# EOF
# )

hostlist=$(cat <<EOF
192.168.104.101     gpmleapcontrolplane1
192.168.104.102     gpmleapcontrolplane2
192.168.104.103     gpmleapcontrolplane3
192.168.104.104     gpmleapworker1
192.168.104.105     gpmleapworker2
192.168.104.106     gpmleapworkergw1
192.168.104.107     gpmleapworkergw2
EOF
)