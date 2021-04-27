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

ADD https://deb.nodesource.com/setup_12.x /tmp/nodejs_setup 
ADD https://github.com/ndw/xmlcalabash1/releases/download/1.2.5-100/xmlcalabash-1.2.5-100.zip /tmp/xmlcalabash.zip

# installing Subversion, Python3, Ant, Saxon, Node and Git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y subversion python3 apt-transport-https ant git libsaxonhe-java && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    chmod 755 /tmp/nodejs_setup && \
    /tmp/nodejs_setup && \
    apt-get install -y nodejs && \
    ln -s /usr/bin/nodejs /usr/local/bin/node && \
    npm install -g yarn && \
    unzip /tmp/xmlcalabash.zip -d /opt && \
    rm /tmp/nodejs_setup /tmp/xmlcalabash.zip

USER jenkins
