#!/bin/bash

docker run -p 12346:12345 -p 8000:8000 --name ${app_name} \
 -e TZ="Asia/Shanghai" \
 -e EMAIL_SENDER_ADDR="YOUR_EMAIL@xxx.com" \
 -e EMAIL_TOKEN="YOUR_EMAIL_TOKEN" \
 -e DB_TYPE="mysql" \
 -e SPRING_PROFILES_ACTIVE="mysql" \
 -e MYSQL_ADDR="YOUR_MYSQL_IP:3306" \
 -e DB_USERNAME="pom_update" \
 -e DB_USER="pom_update" \
 -e DB_PWD="YOUR_PWD" \
 -d registry.cn-hangzhou.aliyuncs.com/itlym/pom-update