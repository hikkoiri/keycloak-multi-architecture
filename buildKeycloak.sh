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

# little tweaks ;)
sed -i '' "s/registry\.access\.redhat\.com\/ubi8-minimal/fedora/g" Dockerfile
sed -i '' "s/microdnf/dnf/g" Dockerfile

# build our own oci image
docker build -t multi-architecture-keycloak:0.0.1 .

# remove intermediate files
cd ../..
rm -rf keycloak-containers