# keycloak-multi-architecture

> The project is still in progress and not finalized. Testing on Raspberry Pi needed. Initial testing on macOs was succesful.

Table of Contents
- [keycloak-multi-architecture](#keycloak-multi-architecture)
  - [What and Why](#what-and-why)
  - [Project Progress](#project-progress)
  - [How it works](#how-it-works)
  - [How to use it](#how-to-use-it)
    - [Build and run it locally on your own](#build-and-run-it-locally-on-your-own)
    - [Dockerhub](#dockerhub)
  - [Caveats](#caveats)

## What and Why

If you want to know what Keycloak is, better read this [documentation](https://www.keycloak.org/).

If you want to know what this project is all about, the answer is simple: Building your own Keycloak OCI image from scratch.
Why? Also a simple answer: The official [Keycloak image on dockerhub](https://hub.docker.com/r/jboss/keycloak/) is only compiled against linux/amd64. But what happens if you want to use Keycloak on a Raspberry Pi or somewhere else? Correct. NOT AVAILABLE. So lets get out hands dirty and build the docker image on our own. Kindly enough they referenced their [source code repository](https://github.com/keycloak/keycloak-containers). At least something...

## Project Progress

> **Remark #1 (22.04.2020)** - Noticed that Keycloak is built on top of the Redhat Universal Base Image (UBI), which does not support ARMv7 or ARMv8. Sighhhh...That could get adventurous.

> **Remark #2  (also the 22.04.2020)** - JACKPOT! It can be so simple. A two-liner makes the deal. More informations can be found in the section 'How it works'.

> **Remark #3  (23.04.2020)** - Just creating a public github repo & dockerhub. I will also add a test docker-compose.yml to verify the docker image on my Raspberry Pi.

## How it works

UBI is a subset of the commercial Red Hat Enterprise Linux distribution. Fedora is the upstream source of RHEL.
Replacing the UBI with the [Fedora](https://hub.docker.com/_/fedora?tab=description) base image and changing the package manager from `microdnf` to `dnf`  in the Dockerfile is all it takes. So you still can use the configuration capibilities over environment variables described here: https://hub.docker.com/r/jboss/keycloak/

## How to use it

### Build and run it locally on your own

If you dont trust public docker registries or want to try it out on yourself, you definitely can. Here are the instructions to build and run your own dockerized Keycloak:

```bash
# prerequisites: git and docker are installed

# clone this project
git clone git@github.com:hikkoiri/keycloak-multi-architecture.git
cd keycloak-multi-architecture

# make the script executable
chmod +x buildKeycloak.sh

# start the script. you need to pass the your desired name for the keycloak image as parameter, like:
# ./buildKeycloack.sh <desired_image_name>
# for example:
./buildKeycloak.sh multi-architecture-keycloak:0.0.1

# et voila, the build should succeed and you can see your container image in the most recently created images
# you may want to change the image name in this file
docker images

# just to be sure: you can test the built image with the the provided docker-compose sample
docker-compose up
```

### Dockerhub

On the other side you can look up [Dockerhub](https://hub.docker.com/repository/docker/hikkoiri/keycloak-multi-architecture) and use the image, which is provided by me.

## Caveats

The built docker image is a round about 200MB bigger, than the original, but I think it is just a little price to pay for the possibilities you gain:

```bash
$ docker images | grep jboss/keycloak
jboss/keycloak                                                             9.0.2                     dbab16e66e04        4 weeks ago         643MB
$ docker images | grep multi-architecture-keycloak
multi-architecture-keycloak                                                0.0.1                     c8bdfb342114        30 minutes ago      816MB
```
