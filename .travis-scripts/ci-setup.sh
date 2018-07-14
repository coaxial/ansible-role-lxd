#!/bin/bash
# Mostly ripped off from https://github.com/lxdock/lxdock/blob/master/scripts/ci-base-setup.sh

sudo -E apt-get update
sudo -E apt-get purge -y lxd lxd-client
sudo -E apt-get install -y snapd
sudo snap install lxd
sudo snap list
sudo lxd --version
sudo snap start lxd

export PATH="/snap/bin:$PATH"

# lxd waitready times out
while [ ! -S /var/snap/lxd/common/lxd/unix.socket ]; do
  sleep 0.5
done

sudo usermod -a -G lxd travis

# lxd init now sets up a bridge so we no longer need to
sudo lxd init --auto

lxc launch ubuntu:18.04 ci -c security.nesting=true
lxc exec ci -- apt install git python -yq
lxc exec ci -- pip install ansible
lxc exec ci -- pip install molecule
lxc exec ci -- git clone --depth=50 https://github.com/coaxial/ansible-role-lxd.git coaxial/ansible-role-lxd

# sudo virtualenv $HOME/travis-venv
# source $HOME/travis-venv/bin/activate
# sudo chmod 666 /var/snap/lxd/common/lxd/unix.socket
# pip install molecule
# pip install ansible
