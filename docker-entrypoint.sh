#!/bin/bash

echo starting server with   $(  nslookup tasks.cockroachdb | grep Address | tail -n +2 | tail -n 3 | sed "s/Address: /,/" | sed "1s/^,/--join=/" | tr -d '\r\n'  )  2>&1


exec /cockroach/cockroach "$@"  $(  nslookup tasks.cockroachdb | grep Address | tail -n +2 | tail -n 3 | sed "s/Address: /,/" | sed "1s/^,/--join=/" | tr -d '\r\n'  )  2>&1

	




