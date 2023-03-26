#!/bin/bash
# 应用名称,可配置
APP_NAME="app"

DEPLOY_DIR=$(cd $(dirname $0)/.. && pwd)                            # 设置start.sh所在父目录为部署目录DEPLOY_DIR
LIB_DIR=$DEPLOY_DIR/lib                                             # jar包所在目录
LIB_JARS=$(ls $LIB_DIR | grep .jar | awk '{print "'$LIB_DIR'/"$0}') # jar包全路径

# 获取当前应用的进程 pid
function get_pid() {
  pgrep -f "java .*${LIB_JARS}"
}

# 退出方法
function stop() {
  local -i timeout=20                     # 退出超时次数20
  local -i interval=1                     # 每次间隔1s
  local -r service_pid=$(get_pid) || true # ignore error
  [[ -n $service_pid ]] || {
    echo "WARNING: process not found, nothing to stop" >&2
    exit 0
  }
  kill $service_pid
  while ((timeout > 0)) && get_pid >/dev/null; do
    echo -n "."ƒ
    sleep $interval
    timeout=$((timeout - interval))
  done
  if get_pid >/dev/null; then
    echo "WARNING: process still alive, sending SIGKILL ..." >&2
    kill -9 "$service_pid"
  fi
  echo "STOP PID: $service_pid"
}

function main() {
  get_pid >/dev/null || {
    echo "WARNING: process not found, nothing to stop" >&2
    exit 0 # Ignore error
  }
  stop
}
main "$@"