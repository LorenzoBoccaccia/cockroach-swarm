#!/bin/bash


LOCAL="$( ip addr | grep inet | grep -v inet6 | sed "s/.*inet //" | sed "s#/.*##" |  tr '\n' '|' | sed "s/|$//" )"

MASTER=$( nslookup tasks.cockroachdb | tail -n +4 | grep Address | wc -l )


JOIN=$( nslookup tasks.cockroachdb | tail -n +3 | grep Address | sed "s/Address: //" | tr '\n' " " | sed "s/ $//" | sed "s/  +/ /" | sed "s/ / --join /g " )

FILE=/cockroach-data/COCKROACHDB_VERSION

if [ -f $FILE ]; then
   echo "Datadir exists  start --insecure --logtostderr=INFO"
   exec "$@" start --insecure --logtostderr=INFO
else
	if [ $MASTER = "1" ]; then
	      echo "\$MASTER is empty start --insecure --logtostderr=INFO"
	      exec "$@" start --insecure --logtostderr=INFO
	else
	      echo "\$MASTERr is NOT empty start --insecure --logtostderr=INFO --join $JOIN"
	      exec "$@" start --insecure --logtostderr=INFO --join $JOIN
	fi
   
fi




