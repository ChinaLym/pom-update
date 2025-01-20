#!/bin/bash

# 删除当前版本，重新下载最新版本

# 应用组名
group_name='itlym'
## 应用名称
app_name='pom-update'
echo '---------- 停止旧容器 ----------'
docker stop ${app_name}
echo '---------- 删除旧容器 ----------'
docker rm ${app_name}
echo '---------- 删除旧镜像 ----------'
docker rmi registry.cn-hangzhou.aliyuncs.com/${group_name}/${app_name}
echo '---------- 打包新镜像 ----------'
#docker build -t ${group_name}/${app_name} .
#echo '---------- 删除无用镜像 ----------'
#docker image prune -f
echo '---------- 创建新容器 ----------'
docker run -p 12346:12345 -p 8000:8000 --name ${app_name} \
 -e TZ="Asia/Shanghai" \
 -e EMAIL_SENDER_ADDR="YOUR_EMAIL@xxx.com" \
 -e EMAIL_TOKEN="YOUR_TOKEN" \
 -e DB_TYPE="mysql" \
 -e SPRING_PROFILES_ACTIVE="mysql" \
 -e MYSQL_ADDR="192.168.3.105:3306" \
 -e DB_USERNAME="pom_update" \
 -e DB_USER="pom_update" \
 -e DB_PWD="pompompom" \
 -d registry.cn-hangzhou.aliyuncs.com/${group_name}/${app_name} \
 java  -Dspring.profiles.active=mysql -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -jar /applications/pom-update/executable.jar