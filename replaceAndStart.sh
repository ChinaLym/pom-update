#!/bin/bash
echo "开始运行Demo服务..."
PARAM=$1;
echo -e "Commit log: "$PARAM;
#----------------------- 基本参数配置 start -----------------------
# JAVA安装目录
JAVA_PATH="/opt/jdk1.8.0_191/bin/java";
# 运行环境配置
JAVA_RUN_ENV="test";
# drone部署的jar包所在路径
DRONE_JAR_PATH="/home/drone/data/demoParant";
# API工程
APP_API_NAME="apiService-0.0.1-SNAPSHOT.jar"
APP_API_PATH="/home/demoPatent/apiService"
APP_API_PING_URL="http://127.0.0.1:18091/api/open/ping"
APP_API_RUN=
# 用户端工程
APP_USER_NAME="userService-0.0.1-SNAPSHOT.jar"
APP_USER_PATH="/home/demoPatent/userService"
APP_USER_RUN=
APP_USER_PING_URL="http://127.0.0.1:18071/user/open/ping"
# 后台服务工程
APP_BACK_NAME="backService-0.0.1-SNAPSHOT.jar"
APP_BACK_PATH="/home/demoPatent/backService"
APP_BACK_RUN=
APP_BACK_PING_URL="http://127.0.0.1:18081/back/open/ping"

# 记录是否有启动失败的服务
APP_START_FAIL=
APP_START_RESULT=
#----------------------- 基本参数配置 end -----------------------

echo "程序运行环境：$JAVA_RUN_ENV"
#----------------------- 定义启动函数 start-----------------------
startAPP() {
    APP_NAME=$1;
    APP_PATH=$2;
    PING_URL=$3;
    # echo "APP_NAME:$APP_NAME"
    # echo "APP_PATH:$APP_PATH"
    # echo "PING_URL:$APP_NAME"
    # 部署新jar包到程序运行目录
    if [ -f "$DRONE_JAR_PATH/$APP_NAME" ];then
        echo "Move the new jar package to the deployment directory ..."
        mv -f $DRONE_JAR_PATH/$APP_NAME $APP_PATH/$APP_NAME
        else
        echo "The drone original jar file not exist, skip move."
    fi

    # 获取程序PID
    getPid() {
        APP_PID=`ps -ef | grep -v grep | grep $APP_NAME | awk '{print $2}'`
    }
    getPid

    # 启动前检查应用是否启动，如果已经启动则先停止再重新启动
    while [ ${APP_PID} ]
    do
        echo -e "App ${APP_NAME} is still RUNNING! PID:$APP_PID";
        echo "stop ${APP_NAME} ...";
        kill -9 ${APP_PID};
        sleep 2;
        getPid
    done

    # 运行jar包
    echo "start ${APP_NAME} ...."
    cd ${APP_PATH}
    nohup ${JAVA_PATH} -server -Xms256m -Xmx512m  -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize=768m -Xss256k -jar ./${APP_NAME} --spring.profiles.active=$JAVA_RUN_ENV > /dev/null & 2>&1 &

    # 请求测试接口，判断服务是否正常启动
    getHttpCode () {
        http_code=`curl -Is -m 10 -w %{http_code} -o /dev/null $PING_URL`;
    }

    # 检查服务启动状态
    sleep 2s;
    count=0;
    # 获取接口状态码
    getHttpCode
    while [ $http_code -ne 200 ]
    do
        if (($count == 8));then
            echo "${APP_NAME}: $(expr $count \* 5)秒内未启动,请检查!";
            msg="start ${APP_NAME} failed!\n";
            echo -e $msg;
            APP_START_RESULT=$APP_START_RESULT$msg;
            APP_START_FAIL="YES";
            return;
        fi
        count=$(($count+1));
        echo "${APP_NAME} waiting to start ...";
        # sleep 1s;
        sleep 5s;
        # 获取接口状态码
        getHttpCode
        echo "http_code --> $http_code";
    done

    getPid
    msg="start ${APP_NAME} success! PID=$APP_PID\n";
    echo -e $msg;
    APP_START_RESULT=$APP_START_RESULT$msg;
}
#----------------------- 函数定义结束 end -----------------------

#----------------------- commit log 判断 start-----------------------
# 根据commit日志参数判断启动哪个工程
if [[ $PARAM == *'[CI API]'* ]]; then
    echo -e "Commit参数指定启动API工程...\n";
    APP_API_RUN="true"
fi

if [[ $PARAM == *'[CI USER]'* ]]; then
    echo -e "Commit参数指定启动用户端工程...\n";
    APP_USER_RUN="true"
fi

if [[ $PARAM == *'[CI BACK]'* ]]; then
    echo -e "Commit参数指定启动BACK工程...\n";
    APP_BACK_RUN="true"
fi

if [[ -z "$APP_API_RUN" ]] && [[ -z "$APP_USER_RUN" ]] && [[ -z "$APP_BACK_RUN" ]]; then
    echo -e "Commit未指定参数，准备启动所有工程...\n";
    APP_API_RUN="true"
    APP_USER_RUN="true"
    APP_BACK_RUN="true"
fi
#----------------------- commit log 判断结束 -----------------------

# 启动运营端服务
if [ $APP_API_RUN ]; then
    echo "Run api service ..."
    startAPP $APP_API_NAME $APP_API_PATH $APP_API_PING_URL
fi
# 启动用户端服务
if [ $APP_USER_RUN ]; then
    echo "Run user service"
    startAPP $APP_USER_NAME $APP_USER_PATH $APP_USER_PING_URL
fi
# 启动商家端服务
if [ $APP_BACK_RUN ]; then
    echo "Run back service"
    startAPP $APP_BACK_NAME $APP_BACK_PATH $APP_BACK_PING_URL
fi


# 删除drone构建缓存
rm -rf $DRONE_JAR_PATH/*.jar

# 打印运行结果
echo "------------ service start status ------------"
echo -e $APP_START_RESULT
echo "----------------------------------------------"

# 如果有启动失败的应用，则退出状态码为1，用于drone标记构建失败
if [ $APP_START_FAIL ]; then
    exit 1;
fi