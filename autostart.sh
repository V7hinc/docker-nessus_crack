cd $(dirname $0);
/etc/init.d/nessusd start;
# 判断文件是否存在
firststart_flag_file="firststart_flag.sh"
if [ -f "$firststart_flag_file" ]; then
  echo "正在执行首次启动任务";
  if [ ! -f "all-2.0.tar.gz" ]; then
    /bin/bash nessus_update_plugins_crack.sh download_plugins;
  fi
  /bin/bash nessus_update_plugins_crack.sh update_plugins;
  /bin/bash nessus_update_plugins_crack.sh nessus_crack;
  rm -f $firststart_flag_file
fi

cron -f >> /var/log/cron_log