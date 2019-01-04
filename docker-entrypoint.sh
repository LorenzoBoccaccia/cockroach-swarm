#!/bin/bash

#wait the nslookup to populate
sleep 5 

cleanup() {
    echo "Container stopped, performing cleanup..."
    /cockroach/cockroach quit --decommission --insecure 
}

trap 'cleanup' SIGTERM


echo starting server with   $(  nslookup tasks.cockroachdb | grep Address | tail -n +2 | tail -n 3 | sed "s/Address: /,/" | sed "1s/^,/--join=/" | tr -d '\r\n'  )  2>&1
/cockroach/cockroach start --insecure --logtostderr   $(  nslookup tasks.cockroachdb | grep Address | tail -n +2 | tail -n 3 | sed "s/Address: /,/" | sed "1s/^,/--join=/" | tr -d '\r\n'  ) 2>&1 &

PID=$!

if [[ $(hostname -s) = cockroachdb.1.* ]]; then
    sleep 5
    /cockroach/cockroach init --insecure
fi
wait $PID



