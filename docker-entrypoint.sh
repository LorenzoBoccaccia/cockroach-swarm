#!/bin/bash

echo "starting server"

exec "$@" start --insecure --logtostderr=INFO
	




