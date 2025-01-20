#!/bin/bash

docker run -p 12346:12345 -p 8000:8000 --name pom-update \
 -e TZ="Asia/Shanghai" \
 -e EMAIL_SENDER_ADDR="YOUR_EMAIL@xxx.com" \
 -e EMAIL_TOKEN="YOUR_EMAIL_TOKEN" \
 -e DB_TYPE="h2" \
 -e SPRING_PROFILES_ACTIVE="h2" \
 -d registry.cn-hangzhou.aliyuncs.com/itlym/pom-update