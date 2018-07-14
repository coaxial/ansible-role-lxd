#!/bin/bash
# Mostly ripped off from https://github.com/lxdock/lxdock/blob/master/scripts/ci-base-setup.sh

set -xe

sudo apt-get update
sudo apt-get install dnsmasq -y
sudo apt-get upgrade -t xenial-backports -y lxd lxd-client
# sudo -E apt-get install -y snapd
# sudo snap install lxd
# sudo snap list

sudo lxd --version
# sudo snap start lxd

# export PATH="/snap/bin:$PATH"

# lxd waitready times out
while [ ! -S /var/lib/lxd/unix.socket ]; do
  sleep 0.5
done
sudo chmod 666 /var/lib/lxd/unix.socket

ip a
# lxd init now sets up a bridge so we no longer need to
lxd init --auto
ip a
# lxc network create lxdbr0
lxc profile show default
# lxc network attach-profile lxdbr0 default eth0
lxc profile show default

lxc network show lxdbr0
ip a

lxc launch ubuntu:18.04 ci -c security.nesting=true
lxc info ci
sleep 15
lxc info ci
lxc exec ci -- ping -c3 1.1.1.1
# lxc exec ci -- sh -c "sudo echo 'nameserver 1.1.1.1' > /etc/resolv.conf"
lxc exec ci -- apt install git python -yq
lxc exec ci -- pip install ansible
lxc exec ci -- pip install molecule
lxc exec ci -- git clone --depth=50 https://github.com/coaxial/ansible-role-lxd.git coaxial/ansible-role-lxd

# sudo virtualenv $HOME/travis-venv
# source $HOME/travis-venv/bin/activate
# sudo chmod 666 /var/snap/lxd/common/lxd/unix.socket
# pip install molecule
# pip install ansible
