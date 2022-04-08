#!/bin/sh

function install()
{
    yum update -y
    yum install -y yum-utils
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install -y docker-ce docker-ce-cli containerd.io
    systemctl enable docker.service
    systemctl enable containerd.service
    systemctl start docker
    yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
    yum -y install vagrant
    groupadd docker
    echo "export VAGRANT_DEFAULT_PROVIDER=docker" > /etc/profile.d/vagrant_povider.sh
    chmod 0755 /etc/profile.d/vagrant_povider.sh
}

sudo bash -c "$(declare -f install); install; usermod -aG docker $USER"
newgrp docker
source ~/.bash_profile
