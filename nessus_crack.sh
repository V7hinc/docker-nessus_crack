set -x;\
# 获取PLUGIN_SET
PLUGIN_SET=$(curl "https://plugins.nessus.org/v2/plugins.php");\
crack_file=/opt/nessus/var/nessus/plugin_feed_info.inc;\
# 将必要的内容写入plugin_feed_info.inc中实现破解
echo 'PLUGIN_SET = "'$PLUGIN_SET'";' > $crack_file;\
echo 'PLUGIN_FEED = "ProfessionalFeed (Direct)";' >> $crack_file;\
echo 'PLUGIN_FEED_TRANSPORT = "Tenable Network Security Lightning";' >> $crack_file;\
/etc/init.d/nessusd restart