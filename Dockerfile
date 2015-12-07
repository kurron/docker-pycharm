FROM kurron/docker-jetbrains-base:latest

MAINTAINER Ron Kurr <kurr@kurron.org>

LABEL org.kurron.ide.name="PyCharm" org.kurron.ide.version=5.0.1 

# Install Python tooling and Ansible 
RUN apt-get update -y && \
    apt-get install -y build-essential python-setuptools python-dev && \
    easy_install pip && \
    pip install ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ADD http://download.jetbrains.com/python/pycharm-professional-5.0.1.tar.gz /tmp/ide.tar.gz

RUN mkdir -p /opt/ide && \
    tar zxvf /tmp/ide.tar.gz --strip-components=1 -C /opt/ide && \
    rm /tmp/ide.tar.gz

ENV PYCHARM_JDK=/usr/lib/jvm/oracle-jdk-8

USER developer:developer
WORKDIR /home/developer
ENTRYPOINT ["/opt/ide/bin/pycharm.sh"]
