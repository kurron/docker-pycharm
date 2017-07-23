FROM kurron/docker-azul-jdk-8-build:latest

MAINTAINER Ron Kurr <kurr@kurron.org>

ENV PYCHARM_JDK /usr/lib/jvm/zulu-8-amd64

ENTRYPOINT ["/opt/pycharm-2017.1.5/bin/pycharm.sh"]

USER root

ADD https://download.jetbrains.com/python/pycharm-professional-2017.1.5.tar.gz /opt

RUN rm -rf /opt/pycharm-2017.1.5/jre64

USER powerless

