export JAVA_MIN_HEAP=2g
export JAVA_MAX_HEAP=4g
export CATALINA_OPTS="-server -d64 -XX:+PrintCommandLineFlags -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:logs/gc.log -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=100m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=logs/heapdump-`date +%Y-%m-%d.%H:%M:%S`.hprof -Xms${JAVA_MIN_HEAP} -Xmx${JAVA_MAX_HEAP} -XX:MaxMetaspaceSize=512m -XX:+UseG1GC -XX:MaxGCPauseMillis=200"
