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

# installing Subversion, Python3, Ant, Saxon, Node, nodejs (lts version), and Git
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends subversion python3 apt-transport-https ant git libsaxonhe-java nodejs make libwww-perl libcss-dom-perl libterm-readkey-perl && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 2 && \
    rm -rf /var/lib/apt/lists/*

# Install W3C linkchecker skript "checklink"
# https://dev.w3.org/perl/modules/W3C/LinkChecker/docs/checklink
RUN PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install W3C::LinkChecker'

# install Yarn package manager for WeGA builds
RUN npm install -g yarn

# install xmlcalabash for BAZGA builds
RUN curl -Ls ${XMLCalabash} -o /tmp/xmlcalabash.zip && \
    unzip /tmp/xmlcalabash.zip -d /opt && \
    rm /tmp/xmlcalabash.zip

USER jenkins
