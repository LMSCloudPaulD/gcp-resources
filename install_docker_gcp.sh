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
    software-properties-common \
    gnupg2

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce

groupadd docker
usermod -aG docker $USER

