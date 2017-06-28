#!/bin/bash


LOCAL="$( ip addr | grep inet | grep -v inet6 | sed "s/.*inet //" | sed "s#/.*##" |  tr '\n' '|' | sed "s/|$//" )"

MASTER=$( nslookup tasks.cockroachdb | tail -n +4 | grep Address | wc -l )

if [ $MASTER = "0" ] ; then
	sleep $[ ( $RANDOM % 100 )  + 1 ]s
fi
 
MASTER=$( nslookup tasks.cockroachdb | tail -n +4 | grep Address | wc -l )


JOIN=$( nslookup tasks.cockroachdb | tail -n +3 | grep Address | sed "s/Address: //" | tr '\n' " " | sed "s/ $//" | sed "s/  +/ /" | sed "s/ / --join /g " )

FILE=/cockroach-data/COCKROACHDB_VERSION

if [ -n $NUM_REPLICAS  ]; then
	echo "setting replicas"
	echo 'num_replicas: $NUM_REPLICAS' | /usr/local/bin/cockroach zone set .default --insecure -f - --host cockroachdb
fi

if [ -f $FILE ]; then
   echo "Datadir exists  start --insecure --logtostderr=INFO --join $JOIN"
   exec "$@" start --insecure --logtostderr=INFO --join $JOIN
else
	if [ $MASTER = "0" ] ; then
	      echo "\$MASTER is $MASTER start --insecure --logtostderr=INFO"
	      exec "$@" start --insecure --logtostderr=INFO
	else
	      echo "\$MASTERr is $MASTER empty start --insecure --logtostderr=INFO --join $JOIN"
	      exec "$@" start --insecure --logtostderr=INFO --join $JOIN
	fi
   
fi




