# pom-update
![icon.png](icon.png)
## 一句话价值：
急速检测直接依赖是否有更新 + 通知

## 同类比较
与 maven 的 `mvn versions:display-dependency-updates` 相比

- pom-update 的第三方版本信息非实时（时间间隔3小时）；maven 是实时检测的，每个依赖都需要至少访问一次中央仓库
- pom-update 的检测时间在毫秒-秒级，并发检测 + 缓存（内存比较无网络）；maven 的检测通常在分钟级，大型项目检测时往往几十分钟
- pom-update 只检测直接依赖 / 自行管理版本的间接依赖，如依赖了 spring-boot，间接依赖（如spring-core) 的版本是不纳入检测的（当且仅当自己在 dependencyManager 中指定了它的版本或显示指定其版本依赖）有利于维护责任独立更轻量；maven 会检测所有依赖以及全部间接依赖
- pom-update 是部署在服务端，不消耗客户端性能，检测时直接出结果；maven 的必须要客户端等待检测结果
- pom-update 可定时检测，支持订阅，如每周发送更新邮件，并能根据是否稳定版设置是否发送邮件通知；maven 不可以

**总结：**

- pom-update 秒级出检测结果，不需要数十分钟等待获取一大堆自己部管理也不关心的间接依赖版本
- pom-update 支持订阅，如每周发送本项目的所有依赖版本变化情况


## 本地运行

1. git clone 本工程
2. 确保有可连接的数据库，将表结构和示例数据导入数据库 [pom-update-schema-and-demo-data.sql](pom-update-schema-and-demo-data.sql)
3. 修改配置文件 或 添加环境变量（二选一）
```text
# 邮箱，如 demo@qq.com
TEST_SENDER_EMAIL
# 邮箱 SFTP token，自行搜索获取
TEST_EMAIL_TOKEN
# MYSQL 地址、用户名、密码
MYSQL_ADDR
MYSQL_PWD
```

## 测试 API
http://localhost:12345/index.html
选择 pom 输入希望接受邮件的邮箱 cn_lym@foxmail.com

http://localhost:12345/test/version
检查所有工程 version

http://localhost:12345/test/notify
给所有需要更新的人发邮件通知

调整通知策略
http://localhost:12345/dependencies/updateNotifyStrategy?projectId=10&notifyStrategy=ALWAYS&email=cn_lym@foxmail.com

```bash
curl --location --request POST 'http://localhost:12345/projects/create' --form 'email=yourEmail@yourEmail.com' --form 'pomXml=@shoulder-dependencies/pom.xml' --form 'notifyInstantlyAfterCheck=true' --form 'notifyReason=CI-<a href="https://cicd.yourdomain.com/xxx/${DRONE_REPO_NAME}">${DRONE_REPO_NAME}::${DRONE_REPO_BRANCH}</a><br> with <a href="https://cicd.yourdomain.cn/gogs/${DRONE_REPO_NAME}/${DRONE_BUILD_NUMBER}">Drone Build-${DRONE_BUILD_NUMBER}</a><br>' || echo '======= SKIP dependency check. ======='
```

---

没有服务器的小伙伴若想拥有一个自己的服务器，可以尝试通过 github 的 actions 等 CI 工具、或者留言~

