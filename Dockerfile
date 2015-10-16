FROM phusion/baseimage:0.9.17
MAINTAINER Mike O'Driscoll <mike@mikeodriscoll.ca>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

CMD ["/sbin/my_init"]

RUN usermod -u 99 nobody
RUN usermod -g 100 nobody

RUN apt-get update -qq
RUN apt-get install -qq -y software-properties-common
RUN apt-add-repository ppa:modriscoll/nzbget
RUN add-apt-repository ppa:kirillshkrogalev/ffmpeg-next
RUN apt-get update -qq
RUN apt-get install -qq -y nzbget ffmpeg wget unrar unzip p7zip git python-pip
RUN apt-get upgrade -qq

# RUN pip install tekuila

RUN cd /tmp && \
wget https://github.com/mikeodr/tekuila/archive/2.0.0.tar.gz -O tekuila.tar.gz && \
tar xzf tekuila.tar.gz && \
cd tekuila-2.0.0 && \
python setup.py install

RUN pip install pynzbget

VOLUME /config
VOLUME /downloads

EXPOSE 6789

RUN mkdir -p /etc/my_init.d
ADD init/setup.sh /etc/my_init.d/setup.sh
RUN chmod +x /etc/my_init.d/setup.sh

#Setup NZBGet init service
RUN mkdir /etc/service/nzbget
ADD init/nzbget.sh /etc/service/nzbget/run
RUN chmod +x /etc/service/nzbget/run
