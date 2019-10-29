#!/bin/bash

#judgement
if [[ -e /etc/supervisor/conf.d/supervisord.conf ]]; then
  exit 0
fi

#supervisor
cat >/etc/supervisor/conf.d/supervisord.conf <<EOF
[supervisord]
nodaemon=true
loglevel = INFO

[unix_http_server]
username = "$(echo "${HOSTNAME}$(date)username" | sha256sum)"
password = "$(echo "${HOSTNAME}$(date)password" | sha256sum)"

[program:postfix]
command=/opt/postfix.sh

[program:rsyslog]
command=/usr/sbin/rsyslogd -n
EOF
