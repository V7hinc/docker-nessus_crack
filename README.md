# docker-nessus_crack
该docker仅做了安装nessus,建立在v7hinc/nessus:v1.0镜像的基础上进行nessus破解
并设置了定时任务，每月进行插件更新

## 使用方法
```shell script
docker pull v7hinc/nessus_crack
docker run -name nessus_crack -p 8834:8834 -dit v7hinc/nessus_crack
```

## 访问方式
使用浏览器访问 https:IP:8834
账号：admin
密码：nimda
