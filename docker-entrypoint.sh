#!/bin/bash

echo "starting server"

exec /cockroach/cockroach "$@"  $(  nslookup tasks.cockroachdb | grep Address | tail -n +2 | tail -n 3 | sed "s/Address: /,/" | sed "1s/^,/--join=/" | tr -d '\r\n'  )

	




