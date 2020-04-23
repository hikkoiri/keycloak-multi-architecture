# keycloak-multi-architecture

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

> **Remark #2 (also the 22.04.2020)** - JACKPOT! It can be so simple. A two-liner makes the deal. More informations can be found in the section 'How it works'.

> **Remark #3 (23.04.2020)** - Just creating a public github repo & dockerhub. I will also add a test docker-compose.yml to test the docker image on my Raspberry Pi.

> **Remark #4 (also the 23.04.2020)** - Hold on a second. Fedora only support armv7 until version tag 29. The latest version tag is 33?! I guess, they have their reasons.

> **Remark #5 (also the 23.04.2020) and hopefully the last one** - Successfully tested Keycloak on the Raspberry Pi. Success!

## How it works

UBI is a subset of the commercial Red Hat Enterprise Linux distribution. Fedora is the upstream source of RHEL.
Replacing the UBI with the [Fedora](https://hub.docker.com/_/fedora?tab=description) base image and changing the package manager from `microdnf` to `dnf`  in the Dockerfile is all it takes. So you still can use the configuration capibilities over environment variables described here: https://hub.docker.com/r/jboss/keycloak/

## How to use it

### Build and run it locally on your own

If you dont trust public docker registries or want to try it out on yourself, you definitely can. Here are the instructions to build and run your own dockerized Keycloak:

```bash
# prerequisites: git and docker are installed

# clone this project
git clone https://github.com/hikkoiri/keycloak-multi-architecture.git
cd keycloak-multi-architecture

# make the script executable
chmod +x buildKeycloak.sh

# start the script. you need to pass the your desired name for the keycloak image as parameter, like:
# ./buildKeycloack.sh <desired_image_name>
# for example:
./buildKeycloak.sh keycloak-multi-architecture:0.0.1

# et voila, the build should succeed and you can see your container image in the most recently created images
# you may want to change the image name in this file
docker images

# just to be sure: you can test the built image with the the provided docker-compose sample
docker-compose up
```

### Dockerhub

On the other side you can look up [Dockerhub](https://hub.docker.com/repository/docker/hikkoiri/keycloak-multi-architecture) and use the image, which is provided by me.

## Caveats

The built docker image is a round about 300MB bigger, than the original, but I think it is just a little price to pay for the possibilities you gain:

```bash
$ docker images | grep keycloak
REPOSITORY                             TAG                 IMAGE ID            CREATED             SIZE
jboss/keycloak                         9.0.2               dbab16e66e04        4 weeks ago         643MB
hikkoiri/keycloak-multi-architecture   0.0.1-x86_64        bd38d15c3de6        10 minutes ago      987MB
hikkoiri/keycloak-multi-architecture   0.0.1-armv7l        70b5568e9b95        9 seconds ago       879MB
```
