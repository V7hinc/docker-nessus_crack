cd $(dirname $0);
nessus_restart(){
  /etc/init.d/nessusd restart;
}
download_plugins(){
  # 获取下载插件下载的链接，这个网上有很多就是根据activation code和challenge code获取，我这边直接一步到位
  download_plugins_url="https://plugins.nessus.org/v2/nessus.php?f=all-2.0.tar.gz&u=91010fb015bb6e1040e3d332a2880d03&p=b527b2904f04ed6ca73541f2e4976554";
  # 下载nessus的插件包
  echo "正在下载插件包";
  curl -k -o all-2.0.tar.gz $download_plugins_url;
}
update_plugins(){
  # 更新插件，这个需要一会儿时间
  /opt/nessus/sbin/nessuscli update all-2.0.tar.gz;
  # 更新完了，删除插件包
  rm -f all-2.0.tar.gz;
  nessus_restart;
  sleep 120;
  curl -k https://127.0.0.1:8834;
  echo "请耐心等待1800秒";
  sleep 1800;
}
nessus_crack(){
  echo "正在破解";
  # 获取PLUGIN_SET
  PLUGIN_SET=$(curl "https://plugins.nessus.org/v2/plugins.php");
  crack_file=/opt/nessus/var/nessus/plugin_feed_info.inc;
  # 将必要的内容写入plugin_feed_info.inc中实现破解
  echo 'PLUGIN_SET = "'$PLUGIN_SET'";' > $crack_file;
  echo 'PLUGIN_FEED = "ProfessionalFeed (Direct)";' >> $crack_file;
  echo 'PLUGIN_FEED_TRANSPORT = "Tenable Network Security Lightning";' >> $crack_file;
  nessus_restart
}
main(){
if [ "$1" = "download_plugins" ]; then
  download_plugins
elif [ "$1" = "update_plugins" ]; then
  update_plugins
elif [ "$1" = "nessus_crack" ]; then
  nessus_crack
else
  download_plugins
  update_plugins
  nessus_crack
fi
}

main "$1"