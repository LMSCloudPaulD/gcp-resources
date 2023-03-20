#!/bin/bash

# Clone koha-testing-docker repository from GitLab
git clone https://gitlab.com/koha-community/koha-testing-docker.git

# Set up LMSTestingDocker repository from GitHub
export LMS_PROJECTS_DIR=~/.local/src/lmsc
export LMS_PROJECTS_DIR="$LMS_PROJECTS_DIR"
export LMS_SYNC_REPO=$LMS_PROJECTS_DIR/Koha-LMSCloud
export LMS_KTD_HOME=$LMS_PROJECTS_DIR/LMSTestingDocker

git clone https://github.com/LMSCloud/LMSTestingDocker.git $LMS_KTD_HOME

cd $KTD_HOME
git checkout -b ktd-lms
rsync -a --exclude='*.md' $LMS_KTD_HOME/* $KTD_HOME

