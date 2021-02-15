##########################################
#
# Dockerfile for the Edirom Jenkins server
# Based on the jenkins/jenkins:lts image
# we add just some additional binaries
#
##########################################
FROM jenkins/jenkins:lts
LABEL maintainer="Peter Stadler for the ViFE"

USER root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y subversion python3 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2

USER ${user}
