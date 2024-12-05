FROM amazoncorretto:21

LABEL author="lym"
LABEL version="1.0"
LABEL description="pomupdate"

COPY . /applications/pom-update/

ENV TZ=Asia/Shanghai

EXPOSE 18180

CMD java -jar /applications/pom-update/executable.jar
