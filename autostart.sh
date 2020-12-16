#!/usr/bin/env bash
/etc/init.d/nessusd start
cron -f >> /var/log/cron_log