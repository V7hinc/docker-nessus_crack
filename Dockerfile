FROM v7hinc/nessus:v1.0
MAINTAINER V7hinc

WORKDIR "/opt/nessus"

COPY nessus_update_plugins_crack.sh /opt/nessus/
COPY autostart.sh /opt/

# crack nessus
RUN set -x;\
/bin/bash /opt/nessus/nessus_update_plugins_crack.sh

# add regular execution to crontab
RUN set -x;\
apt-get install vim cron -y;\
# 编写定时任务，每月1号更新插件包
echo '0 0 1 * * /bin/bash /opt/nessus/nessus_update_plugins_crack.sh' > /opt/crontabfile;\
crontab /opt/crontabfile;\
crontab -l;


EXPOSE 8834
CMD /opt/autostart.sh
