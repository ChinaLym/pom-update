# 🐋 Run with Docker

## ⚡ Type1: Use Embedded Database(H2)

First, prepare an email and emailToken(obtain from your email settings)

Just run the script with your email and token.

```bash
docker run -p 12346:12345 -p 8000:8000 --name pom-update \
 -e TZ="Asia/Shanghai" \
 -e EMAIL_SENDER_ADDR="YOUR_EMAIL@xxx.com" \
 -e EMAIL_TOKEN="YOUR_EMAIL_TOKEN" \
 -e DB_TYPE="h2" \
 -d registry.cn-hangzhou.aliyuncs.com/itlym/pom-update
```

## 🐬 Type2: Use MySQL

First, prepare an email and emailToken(obtain from your email settings)

Just run the script with your email and database settings.

```bash
docker run -p 12346:12345 -p 8000:8000 --name ${app_name} \
-e TZ="Asia/Shanghai" \
-e EMAIL_SENDER_ADDR="YOUR_EMAIL@xxx.com" \
-e EMAIL_TOKEN="YOUR_EMAIL_TOKEN" \
-e DB_TYPE="mysql" \
-e MYSQL_ADDR="YOUR_MYSQL_IP:3306" \
-e DB_USERNAME="pom_update" \
-e DB_USER="pom_update" \
-e DB_PWD="YOUR_PWD" \
-d registry.cn-hangzhou.aliyuncs.com/itlym/pom-update

```

----

**Give me a [🌟Star](https://gitee.com/ChinaLym/shoulder-framework/star)** if you like the project, Thanks ❀
