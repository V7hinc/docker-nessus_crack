set -x;\
# 获取下载插件下载的链接，这个网上有很多就是根据activation code和challenge code获取，我这边直接一步到位
download_plugins_url="https://plugins.nessus.org/v2/nessus.php?f=all-2.0.tar.gz&u=91010fb015bb6e1040e3d332a2880d03&p=b527b2904f04ed6ca73541f2e4976554";\
# 下载nessus的插件包
curl -k -o all-2.0.tar.gz $download_plugins_url;\
# 如果你已经下载好了插件包，就可以跳过上面2步，直接执行下面的步骤
# 更新插件，这个需要一会儿时间
/opt/nessus/sbin/nessuscli update all-2.0.tar.gz;\
# 更新完了，删除插件包
rm -f all-2.0.tar.gz;\
/etc/init.d/nessusd restart;\
sleep 120;\
curl -k https://127.0.0.1:8834;\
sleep 2000;
