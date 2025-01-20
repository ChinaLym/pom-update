FROM docker.1ms.run/openjdk:21

LABEL author="lym"
LABEL version="1.1"
LABEL description="pomupdate"

COPY target/executable.jar run.sh /applications/pom-update/

ENV TZ=Asia/Shanghai
ENV H2_FILE_PATH=~/pomUpdateDb

EXPOSE 12345
EXPOSE 8000

CMD java -jar /applications/pom-update/executable.jar
