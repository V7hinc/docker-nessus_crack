#!/usr/bin/env bash
# 获取下载插件下载的链接，这个网上有很多就是根据activation code和challenge code获取，我这边直接一步到位
download_plugins_url="https://plugins.nessus.org/v2/nessus.php?f=all-2.0.tar.gz&u=91010fb015bb6e1040e3d332a2880d03&p=b527b2904f04ed6ca73541f2e4976554";
# 下载nessus的插件包
curl -k -o all-2.0.tar.gz $download_plugins_url;
# 如果你已经下载好了插件包，就可以跳过上面2步，直接执行下面的步骤
# 更新插件，这个需要一会儿时间
/opt/nessus/sbin/nessuscli update all-2.0.tar.gz;
# 更新完了，删除插件包
rm -f all-2.0.tar.gz;
# 获取PLUGIN_SET
PLUGIN_SET=$(curl "https://plugins.nessus.org/v2/plugins.php");
crack_file=/opt/nessus/var/nessus/plugin_feed_info.inc;
# 将必要的内容写入plugin_feed_info.inc中实现破解
echo 'PLUGIN_SET = "'$PLUGIN_SET'";' > $crack_file;
echo 'PLUGIN_FEED = "ProfessionalFeed (Direct)";' >> $crack_file;
echo 'PLUGIN_FEED_TRANSPORT = "Tenable Network Security Lightning";' >> $crack_file