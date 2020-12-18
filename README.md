# docker-nessus_crack
该docker仅做了安装nessus,建立在v7hinc/nessus:8.13.0-ubuntu镜像的基础上进行nessus破解
并设置了定时任务，每月进行插件更新

## 版本说明
```text
v7hinc/nessus_crack:8.13.0-full-ubuntu    完整版，插件已经解压，此时整个容器较大，拉取下来后可以直接使用。下载时间会比较长
v7hinc/nessus_crack:8.13.0-lite-ubuntu    轻量版，插件已经下载，但是未解压，此时整个容器小，拉取下来后需等待解压插件包。下载时间相对较短，首次启动时间会比较长
```

## 使用方法
```shell script
docker pull v7hinc/nessus_crack
docker run -name nessus_crack -p 8834:8834 -dit v7hinc/nessus_crack
```

## 访问方式
使用浏览器访问 https:IP:8834
账号：admin
密码：nimda
