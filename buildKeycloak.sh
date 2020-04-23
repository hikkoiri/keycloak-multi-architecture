#!/bin/sh

if [ -z "$1" ]
then
    echo "No argument supplied. Please pass a name for the container image as parameter."
    exit 1
fi
echo Chose image name: $1

# clone official keycloak sources
git clone https://github.com/keycloak/keycloak-containers
cd keycloak-containers/server

# here comes the interesting part
# sed command needs to be different between mac & linux 
if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    sed -i '' "s/registry\.access\.redhat\.com\/ubi8-minimal/fedora:29/g" Dockerfile
    sed -i '' "s/microdnf/dnf/g" Dockerfile
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    sed -i "s/registry\.access\.redhat\.com\/ubi8-minimal/fedora:29/g" Dockerfile
    sed -i "s/microdnf/dnf/g" Dockerfile
fi

# build our own oci image
docker build -t $1 .

# remove intermediate files
cd ../..
rm -rf keycloak-containers