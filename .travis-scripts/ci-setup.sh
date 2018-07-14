#!/bin/bash
sudo apt-get update
# sudo apt-get install dnsmasq -y
sudo apt-get upgrade -t xenial-backports -y lxd lxd-client
sudo lxd --version
sudo lxd waitready
sudo lxd init --auto
pip install ansible
pip install molecule
