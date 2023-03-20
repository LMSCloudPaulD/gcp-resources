#!/bin/bash

# Check if running with root privileges
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root. Please enter your sudo password below:"
    # Prompt for sudo password
    exec sudo "$0" "$@"
fi

apt-get update

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install -y docker-ce

groupadd docker
usermod -aG docker $USER

