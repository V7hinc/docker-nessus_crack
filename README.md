# docker-nessus_crack
该docker仅做了安装nessus,建立在v7hinc/nessus:v1.0镜像的基础上进行nessus破解
并设置了定时任务，每月进行插件更新

## 使用方法
```shell script
docker pull v7hinc/nessus_crack
docker run -name nessus_crack -p 8834:8834 -dit v7hinc/nessus_crack
```

## 第一次访问
打开浏览器访问https://IP:8834，进入到初始化选择安装界面
这里我们要选择 Managed Scanner。
点击继续，然后这里一定要选择Tenable.sc。
然后设置用户名密码
这时候看到页面只有setting，没有scan

## 执行安装插件代码
```shell script

```
打开浏览器访问https://IP:8834，进入插件编译过程，这个进度会比较慢
如果编译插件过程中发生无法访问情况可执行```/etc/init.d/nessusd restart```
