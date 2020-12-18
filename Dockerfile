FROM v7hinc/nessus:8.13.0-ubuntu
MAINTAINER V7hinc

ENV USERNAME=admin
ENV PASSWORD=nimda

COPY autostart.sh /opt/nessus/
COPY firststart_flag.sh /opt/nessus/
COPY nessus_update_plugins_crack.sh /opt/nessus/

WORKDIR "/opt/nessus"

# init nessus
RUN set -x;\
# 启动nessus
/etc/init.d/nessusd start;\
sleep 20;\
# 先访问一下主页
curl -k https://127.0.0.1:8834;\
# 设置一下账号密码
sleep 60;\
curl -k -XPOST https://127.0.0.1:8834/users -H "Content-Type: application/json" -d "{\"username\":\"$USERNAME\",\"password\":\"$PASSWORD\",\"permissions\":128}";\
# 重启一下
sleep 30;\
curl -k -XPOST https://127.0.0.1:8834/server/restart;\
sleep 20;


# add regular execution to crontab
RUN set -x;\
apt-get install vim cron -y;\
# 编写定时任务，每月1号更新插件包
echo '0 0 1 * * /bin/bash /opt/nessus/nessus_update_plugins_crack.sh' > /opt/crontabfile;\
crontab /opt/crontabfile;\
crontab -l;

# 仅下载插件
RUN set -x;\
/bin/bash nessus_update_plugins_crack.sh download_plugins;\
ls -l;


EXPOSE 8834
CMD /bin/bash /opt/nessus/autostart.sh
