#!/bin/bash

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
    echo "Error: Docker is not installed. Please run the previous script to install Docker first." >&2
    exit 1
fi

# Check if user is part of docker group
if ! groups | grep "\bdocker\b" >/dev/null; then
    echo "Error: User is not part of the docker group. Please run the previous script to add the user to the docker group." >&2
    exit 1
fi

# Clone koha-testing-docker repository from GitLab
git clone https://gitlab.com/koha-community/koha-testing-docker.git

# Check if the repository was cloned successfully
if [ ! -d "koha-testing-docker" ]; then
    echo "Error: koha-testing-docker repository was not cloned successfully." >&2
    exit 1
fi

# Set up required environment variables
export LMS_PROJECTS_DIR=~/.local/src/lmsc
export LMS_PROJECTS_DIR="$LMS_PROJECTS_DIR"
export LMS_SYNC_REPO=$LMS_PROJECTS_DIR/Koha-LMSCloud
export LMS_KTD_HOME=$LMS_PROJECTS_DIR/LMSTestingDocker

# Check if required environment variables are set up
if [ -z "$LMS_PROJECTS_DIR" ] || [ -z "$LMS_SYNC_REPO" ] || [ -z "$LMS_KTD_HOME" ]; then
    echo "Required environment variables not found. Please set up the environment variables first." >&2
    exit 1
fi

# Set up LMSTestingDocker repository from GitHub
git clone https://github.com/LMSCloud/LMSTestingDocker.git $LMS_KTD_HOME

cd $KTD_HOME
git checkout -b ktd-lms
rsync -a --exclude='*.md' $LMS_KTD_HOME/* $KTD_HOME

