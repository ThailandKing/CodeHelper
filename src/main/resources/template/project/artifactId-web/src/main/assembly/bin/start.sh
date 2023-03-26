#!/bin/bash
# 应用名称,可配置
APP_NAME="app"
# java内存参数,可配置
JAVA_MEM_OPTS_DEFAULT=" -server -XX:MaxRAMPercentage=60.0 -XX:InitialRAMPercentage=60.0 -XX:MinRAMPercentage=60.0 -XX:MaxMetaspaceSize=256m -Xss256k"
# 设置start.sh所在父目录为部署目录DEPLOY_DIR
DEPLOY_DIR=$(cd $(dirname $0)/.. && pwd)
# jar包所在目录
LIB_DIR=$DEPLOY_DIR/lib
# jar包全路径
LIB_JARS=$(ls ${LIB_DIR} | grep .jar | awk '{print "'$LIB_DIR'/"$0}') # jar包全路径
# 设置java执行路径
JAVA_EXE=$JAVA_HOME/bin/java

# $JAVA_EXE 不是可执行文件时,则退出
[[ -x $JAVA_EXE ]] || {
  echo "ERROR: no executable java found at $JAVA_EXE" >&2
  exit 1
}

# 如果没有配置内存参数,取默认的$JAVA_MEM_OPTS_DEFAULT
if test -z "${JAVA_MEM_OPTS}"; then
  JAVA_MEM_OPTS=$JAVA_MEM_OPTS_DEFAULT
fi

# 获取当前应用的进程 pid
function get_pid() {
  pgrep -f "java .*${LIB_JARS}"
}
# 如果当前PID不存在,则退出
[[ -z $(get_pid) ]] || {
  echo "ERROR:  $APP_NAME already running" >&2
  echo "ALREADY RUNNING PID: $PIDS"
  exit 1
}

echo "Starting $APP_NAME ...."
cd $DEPLOY_DIR
setsid ${JAVA_EXE} $JAVA_MEM_OPTS -jar $LIB_JARS "$@" >/dev/null 2>&1 &

# 等待0.5s,如果进程pid不存在,报错退出
sleep 0.5
[[ -n $(get_pid) ]] || {
  echo "ERROR: $APP_NAME failed to start" >&2
  exit 1
}

# 打印成功日志
echo "START PID: $(get_pid)"
echo "$APP_NAME is up running :)"