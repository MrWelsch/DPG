#!/bin/sh

# Iterates over each Environment variable that begins with 
# BRIDGE_IP_NETWORK_ for as long as there are variables that match.
# In each iteration the according network interface will be flushed and assigned
# a new ip adress.
# REGEX EXPLANATION:
# "${i#*=}"
# example: i = BRIDGE_IP_NETWORK_A=10.1.0.3/16 -> 10.1.0.3/16
network_interface='eth'
network_interface_number=0
printenv | grep BRIDGE_IP_NETWORK_ |
while IFS= read -r i; do
    ip addr flush dev "${network_interface}${network_interface_number}"
    ip addr add "${i#*=}" dev "${network_interface}${network_interface_number}"
    network_interface_number=$((network_interface_number+1))
done