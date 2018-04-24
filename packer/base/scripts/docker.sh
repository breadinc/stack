#!/bin/bash
set -e

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

apt-get update -y
apt-get purge -y lxc-docker
apt-cache policy docker-ce

apt-get install -o Dpkg::Options::="--force-confold" -y \
        linux-image-extra-$(uname -r) \
        docker-ce

gpasswd -a ubuntu docker

systemctl daemon-reload
systemctl enable format-var-lib-docker.service
systemctl enable var-lib-docker.mount
systemctl enable docker.service
