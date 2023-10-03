java  \
-Xms256M -Xmx256M  \
-XX:ReservedCodeCacheSize=32m -XX:InitialCodeCacheSize=32m  \
-XX:+UnlockExperimentalVMOptions -XX:+UseZGC  \
-XX:ConcGCThreads=1 -XX:ParallelGCThreads=2  \
-XX:ZCollectionInterval=120 -XX:ZAllocationSpikeTolerance=3  \
-Xlog:safepoint,classhisto*=trace,age*,gc*=info:file=/opt/bin/java/logs/gc-%t.log:time,tid,tags:filecount=5,filesize=50m  \
-verbose:gc \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-Dsun.rmi.dgc.server.gcInterval=2592000000 \
-Dsun.rmi.dgc.client.gcInterval=2592000000 \
-server \
-Dfile.encoding=UTF-8 \
-XX:+HeapDumpOnOutOfMemoryError \
-XX:HeapDumpPath=/opt/bin/java/logs \
-XX:ErrorFile=/opt/bin/java/logs/hs_err_pid%p.log \
-Xloggc:/opt/bin/java/logs/gc.log \
-Xdebug \
-Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n \
-Dspring.config.additional-location=/opt/bin/java/config/application.properties \
-jar \
/opt/bin/java/executable.jar