#!/bin/bash

sudo ip netns add mynamespace

sudo ip netns list
sudo ip netns exec mynamespace ip addr

sudo ip link add veth0 type veth peer name veth1
sudo ip link set veth1 netns mynamespace

sudo ip addr add 10.0.0.1/24 dev veth0
sudo ip link set veth0 up

sudo ip netns exec mynamespace ip addr add 10.0.0.2/24 dev veth1
sudo ip netns exec mynamespace ip link set veth1 up

# sudo ip netns exec mynamespace ping 10.0.0.1