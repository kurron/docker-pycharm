FROM python:latest

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="PyCharm" org.kurron.ide.version=5.0.1 

# replicate kurron/docker-oracle-jdk-8
ENV DEBIAN_FRONTEND noninteractive

# Install JDK 8 
RUN wget --quiet \
         --output-document=/jdk-8.tar.gz \
         --no-check-certificate \
         --no-cookies \
         --header "Cookie: oraclelicense=accept-securebackup-cookie" \
         http://download.oracle.com/otn-pub/java/jdk/8u65-b17/jdk-8u65-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables 
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_65 
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_65
ENV PATH $PATH:$JAVA_HOME/bin

# Force Docker to use UTF-8 encodings
ENV LANG C.UTF-8

# export meta-data about this container
LABEL org.kurron.java.vendor="Oracle"  org.kurron.java.version="1.8.0_65"

# replicate kurron/docker-jetbrains-base
# Install the libraries needed to run a JVM in GUI mode
RUN apt-get update && \
    apt-get install -y libgtk2.0-0 libcanberra-gtk-module libxext-dev libxrender-dev libxtst-dev python-dev git subversion mercurial && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install Python packages
RUN pip install --upgrade pip pycrypto

# Create a user and group that matches what is in most Vagrant boxes
RUN groupadd --gid 1000 developer && \
    useradd --gid 1000 --uid 1000 --create-home --shell /bin/bash developer && \
    chown -R developer:developer /home/developer

# Set the environment to use the new user account
#USER developer:developer
#WORKDIR /home/developer
ENV HOME /home/developer

# the user of this image is expected to mount his actual home directory to this one
VOLUME ["/home/developer"]

ADD https://download.jetbrains.com/python/pycharm-professional-5.0.2.tar.gz /tmp/ide.tar.gz

RUN mkdir -p /opt/ide && \
    tar zxvf /tmp/ide.tar.gz --strip-components=1 -C /opt/ide && \
    rm /tmp/ide.tar.gz

ENV PYCHARM_JDK=/usr/lib/jvm/oracle-jdk-8

USER developer:developer
WORKDIR /home/developer
ENTRYPOINT ["/opt/ide/bin/pycharm.sh"]
