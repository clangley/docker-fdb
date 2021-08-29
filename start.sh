#!/bin/sh
#cp /etc/fdb/foundationdb.conf /etc/foundationdb/foundationdb.conf
export FDB_IP=$(python3 get_ip.py)
cat /etc/fdb/foundationdb.conf | envsubst "\$FDB_IP" > /etc/foundationdb/foundationdb.conf
if [ ! -f /etc/foundationdb/fdb.cluster ]
then
    if [ "$1" = "" ]
    then
        echo "Configure new cluster."
        echo "docker:docker@$FDB_IP:4500" > /etc/foundationdb/fdb.cluster
        (sleep 3 && fdbcli --no-status --exec "configure new single ssd" &)
    else
        echo "Replace $FDB_CLUSTER_FILE with $1 to join."
        echo $1 > /etc/foundationdb/fdb.cluster
    fi
fi
exec /usr/lib/foundationdb/fdbmonitor
