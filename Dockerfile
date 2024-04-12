# Storman-MaxView

FROM phusion/baseimage:bionic-1.0.0

MAINTAINER X-Tek dockerfile@xtekmail.com

ARG DEBIAN_FRONTEND="noninteractive"

ENV JAVA_HOME="/usr/StorMan/jre"

ENV STORMAN_PASS="docker"

ENV TZ="America/Chicago"

ENV LANG="en_US"

CMD ["/sbin/my_init"]

COPY files /app

WORKDIR /app

RUN echo root:${STORMAN_PASS} | chpasswd

RUN apt update -y

RUN apt purge openssh-client openssh-server openssh-sftp-server -y

RUN apt upgrade -o Dpkg::Options::="--force-confold" -y

RUN apt install net-tools unzip procps ncurses-bin iptables ufw -y

RUN dpkg -i /app/StorMan-3.07-23980_amd64.deb

RUN mv /app/arcconf /bin

RUN mv /app/start-storman /etc/my_init.d/start-storman

RUN mv /app/stor_redfishserver /etc/init.d/stor_redfishserver

RUN mv /app/stor_tomcat /etc/init.d/stor_tomcat

RUN chmod 775 /etc/init.d/stor_redfishserver /etc/init.d/stor_tomcat /etc/my_init.d/start-storman

RUN rm /app/*.deb

EXPOSE 8443

HEALTHCHECK --interval=1m --timeout=5s --retries=3 \
  CMD curl -skSL -D - https://localhost:8443 -o /dev/null || exit 1

