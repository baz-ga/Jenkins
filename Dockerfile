##########################################
#
# Dockerfile for the Edirom Jenkins server
# Based on the jenkins/jenkins:lts image
# we add just some additional binaries
#
##########################################
FROM jenkins/jenkins:lts-jdk11
LABEL maintainer="Peter Stadler for the ViFE"
LABEL org.opencontainers.image.source="https://github.com/Edirom/Jenkins"

USER root

ARG XMLCalabash=https://github.com/ndw/xmlcalabash1/releases/download/1.2.5-100/xmlcalabash-1.2.5-100.zip

# installing Subversion, Python3, Ant, Saxon, Node, NPM, and Git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends subversion python3 apt-transport-https ant git libsaxonhe-java npm && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    rm -rf /var/lib/apt/lists/*

# install Yarn package manager for WeGA builds
RUN npm install -g yarn

# install xmlcalabash for BAZGA builds
RUN curl -Ls ${XMLCalabash} -o /tmp/xmlcalabash.zip && \
    unzip /tmp/xmlcalabash.zip -d /opt && \
    rm /tmp/xmlcalabash.zip

USER jenkins
