#!/bin/bash

ARCH=$(uname -m)

if [ "$ARCH" == "x86_64" ]; then
    DOCKER_URL="https://download.docker.com/linux/debian"
    DOCKER_KEY="9DC858229FC7DD38854AE2D88D81803C0EBFCD88"
    DOCKER_KEY_SERVER="hkp://p80.pool.sks-keyservers.net:80"
    DOCKER_REPO="stable"
    DOCKER_ARCH="amd64"
elif [ "$ARCH" == "aarch64" ]; then
    DOCKER_URL="https://download.docker.com/linux/debian"
    DOCKER_KEY="8D81803C0EBFCD88"
    DOCKER_KEY_SERVER="hkp://p80.pool.sks-keyservers.net:80"
    DOCKER_REPO="stable"
    DOCKER_ARCH="arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

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

curl -fsSL $DOCKER_URL/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
    "deb [arch=$DOCKER_ARCH signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] $DOCKER_URL \
    $(lsb_release -cs) $DOCKER_REPO" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install -y docker-ce

groupadd docker
usermod -aG docker $USER

