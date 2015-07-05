#!/bin/bash

# Check if nzbget.conf exists. If not, copy in the sample config
if [ -f /config/nzbget.conf ]; then
  echo " Using existing nzbget.conf file."
else
  cp /usr/share/nzbget/nzbget.conf /config
  sed -i -e "s#\(MainDir=\).*#\1/downloads#g" /config/nzbget.conf
  sed -i -e "s#\(ControlIP=\).*#\10.0.0.0#g" /config/nzbget.conf
  sed -i -e "s#\(UMask=\).*#\1000#g" /config/nzbget.conf
  sed -i -e "s#\(ScriptDir=\).*#\1/config/ppscripts#g" /config/nzbget.conf
  sed -i -e "s#\(QueueDir=\).*#\1/config/queue#g" /config/nzbget.conf
  sed -i -e "s#\(LogFile=\).*#\1/config/log/nzbget.logs#g" /config/nzbget.conf
  chown nobody:users /config/nzbget.conf
  mkdir -p /downloads/dst
  chown -R nobody:users /downloads
fi

# Verify and create come directories
if [[ ! -e /config/queue ]]; then
  mkdir -p /config/queue
  chown -R nobody:users /config/queue
fi

if [[ ! -e /config/log ]]; then
  mkdir -p /config/log
  chown -R nobody:users /config/log
fi

if [[ ! -e /config/ppscripts ]]; then
  mkdir -p /config/ppscripts
  chown -R nobody:users /config/ppscripts
fi

if [[ ! -e /config/ppscripts/nzbToMedia ]]; then
  git clone https://github.com/clinton-hall/nzbToMedia.git /config/ppscripts/nzbToMedia
  chown -R nobody:users /config/ppscripts/nzbToMedia
fi

if [[ ! -e /config/ppscripts/GetScripts ]]; then
  git clone https://github.com/clinton-hall/GetScripts.git /config/ppscripts/GetScripts
  chown -R nobody:users /config/ppscripts/GetScripts
fi

if [[ ! -e /config/ppscripts/tekuilaget ]]; then
  git clone https://github.com/mikeodr/tekuilaget.git /config/ppscripts/tekuilaget
  chown -R nobody:users /config/ppscripts/tekuilaget
fi
