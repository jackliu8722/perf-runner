#!/bin/bash
##################################################################
# 
# written by haitao.yao @ 2011-09-16.23:47:31
# 
# this is used to start all the collectors 
# 
##################################################################
current_dir="$(cd $(dirname $0);pwd)"
. $current_dir/env.sh

perf_test_name=$1
if [ -z "$perf_test_name" ]
then
	echo "no perf_test_name"
	echo "Usage: $0 perf_test_name perf_test_uuid"
	exit 1
fi
perf_test_uuid=$3
if [ -z "$perf_test_uuid" ]
then
	echo "no perf_test_uuid"
	echo "Usage: $0 perf_test_name perf_test_uuid"
	exit 1
fi

server_group=$2
if [ -z "$server_group" ]
then
	echo "no server_group"
	echo "Usage: $0 perf_test_name perf_test_uuid server_group"
	exit 1
fi

perf_log_dir=$(get_perf_test_log_dir)

cd $PERF_RUNNER_HOME/collectors
perf_pid_dir=$(get_perf_test_runtime_dir)
for perf_collector in $(ls |sort)
do
	nohup $perf_collector/start.sh >> $perf_log_dir/$perf_collector.csv 2>/dev/null&
	echo $! > $perf_pid_dir/$perf_collector.pid
done
