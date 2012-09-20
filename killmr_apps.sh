#TODO: replace with equivalent hadoop application admin tool invocation rather than crudely using jps.
KILL_PIDS=`jps | grep "MRAppMaster" | awk '{print $1}'`

while [ -n "$KILL_PIDS" ]; do

    echo "killing running applications.."
    for PID in $KILL_PIDS
    do
	ROLE=`jps | grep "MRAppMaster" | grep $PID | awk '{print $2}'`
	echo "killing: $PID ($ROLE)"
	kill $PID
    done

    sleep 10

    #terminate any stragglers
    KILL_PIDS=`jps | grep "MRAppMaster" | awk '{print $1}'`
    for PID in $KILL_PIDS
    do
	ROLE=`jps | grep "MRAppMaster" | grep $PID | awk '{print $2}'`
	echo "terminating straggler: $PID ($ROLE)"
	kill -9 $PID
    done

    sleep 3
    KILL_PIDS=`jps | grep "MRAppMaster" | awk '{print $1}'`
done
