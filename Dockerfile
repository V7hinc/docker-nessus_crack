FROM v7hinc/nessus:8.13.0-ubuntu
MAINTAINER V7hinc

ENV USERNAME=admin
ENV PASSWORD=nimda

COPY nessus_update_plugins_crack.sh /opt/nessus/
COPY nessus_update_plugins.sh /opt/nessus/
COPY nessus_crack.sh /opt/nessus/

WORKDIR "/opt/nessus"

# init nessus
RUN set -x;\
# 启动nessus
/etc/init.d/nessusd start;\
sleep 10;\
# 先访问一下主页
curl -k https://127.0.0.1:8834;\
# 设置一下账号密码
sleep 60;\
curl -k -XPOST https://127.0.0.1:8834/users -H "Content-Type: application/json" -d "{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"permissions\":128}";\
# 重启一下
sleep 10;\
curl -k -XPOST https://127.0.0.1:8834/server/restart;\
sleep 120;\
curl -k https://127.0.0.1:8834;

# add regular execution to crontab
RUN set -x;\
apt-get install vim cron -y;\
# 编写定时任务，每月1号更新插件包
echo '0 0 1 * * /bin/bash /opt/nessus/nessus_update_plugins_crack.sh' > /opt/crontabfile;\
crontab /opt/crontabfile;\
crontab -l;

RUN set -x;\
# 编写自启动脚本
echo '/etc/init.d/nessusd start;cron -f >> /var/log/cron_log' > /opt/autostart.sh

# crack nessus
RUN set -x;\
# 更新插件
/bin/bash /opt/nessus/nessus_update_plugins.sh;\
# 执行破解脚本
/bin/bash /opt/nessus/nessus_crack.sh;

EXPOSE 8834
CMD /bin/bash /opt/autostart.sh
