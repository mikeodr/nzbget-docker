#!/bin/bash

exec supervisord -c /etc/supervisor.conf -n
