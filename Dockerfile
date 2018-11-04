FROM phusion/baseimage:0.11
MAINTAINER Mike O'Driscoll <mike@mikeodriscoll.ca>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

CMD ["/sbin/my_init"]

RUN usermod -u 99 nobody && \
usermod -g 100 nobody

RUN apt-get update -qq && \
apt-get install -qq -y software-properties-common && \
apt-add-repository ppa:modriscoll/nzbget && \
apt-get update -qq && \
apt-get install -qq -y nzbget wget unrar unzip p7zip git python-pip supervisor && \
apt-get upgrade -qq && apt-get autoclean && apt-get autoremove && \
rm -rf /var/lib/apt/lists/*

RUN pip install tekuila
RUN pip install pynzbget

VOLUME /config
VOLUME /downloads

EXPOSE 6789

RUN mkdir -p /etc/my_init.d
ADD init/setup.sh /etc/my_init.d/setup.sh
RUN chmod +x /etc/my_init.d/setup.sh

#Setup NZBGet init service
RUN mkdir /etc/service/supervisor
ADD init/supervisor.conf /etc/supervisor.conf
ADD init/supervisor.sh /etc/service/supervisor/run
RUN chmod +x /etc/service/supervisor/run
