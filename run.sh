# 可参考的服务器运行脚本

java  \
-Xms256M -Xmx256M  \
-XX:ReservedCodeCacheSize=32m -XX:InitialCodeCacheSize=32m  \
-XX:+UnlockExperimentalVMOptions -XX:+UseZGC  \
-XX:ConcGCThreads=1 -XX:ParallelGCThreads=2  \
-XX:ZCollectionInterval=120 -XX:ZAllocationSpikeTolerance=3  \
-Xlog:safepoint,classhisto*=trace,age*,gc*=info:file=/applications/pom-update/jvmlog/gc-%t.log:time,tid,tags:filecount=5,filesize=50m  \
-verbose:gc \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-Dsun.rmi.dgc.server.gcInterval=2592000000 \
-Dsun.rmi.dgc.client.gcInterval=2592000000 \
-server \
-Dfile.encoding=UTF-8 \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/applications/pom-update/jvmlog \
-XX:ErrorFile=/applications/pom-update/jvmlog/hs_err_pid%p.log \
-Xloggc:/applications/pom-update/jvmlog/gc.log \
-Xdebug \
-Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n \
-jar \
/opt/executable.jar