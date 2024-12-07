FROM docker.rainbond.cc/amazoncorretto:21

LABEL author="lym"
LABEL version="1.02"
LABEL description="pomupdate"

COPY target/executable.jar run.sh application.yml data.sql schema.sql /applications/pom-update/

ENV TZ=Asia/Shanghai

EXPOSE 12345
EXPOSE 8000

CMD java -jar /applications/pom-update/executable.jar
