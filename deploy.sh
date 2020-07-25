#!/bin/bash

# Generic deploy script for containered applications.
# (1) Each application should have a Github repo cloned into the same directory as
#     this script with an .envrc script to set environment variables.
# (2) Each application should also have its own deploy SSH key, so that we can
#     restrict that key to the one command it should be authorized to run: the
#     app-specific deploy-<app name>.sh script.
# (3) The app-specific script can just call this generic deploy script with the
#     repo's directory name as the only parameter
# (4) Deploy process just changes to the project's directory, sources .envrc for
#     the environment, pulls the latest changes and restarts the app with the
#     corresponding image for the current commit.

cd /home/deploy/$1
. .envrc
git pull

docker-compose down

# Pass short version of current commit as the image tag
COMMIT=`git rev-parse --short HEAD` docker-compose -f docker-compose.yml -f docker-compose-prod.yml up -d
