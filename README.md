# Cockroach Swarm

A container that properly* scales nodes respecting the docker swarm semantics

The swarm service must be named cockroachdb and must run within an overlay network

You can add as many node as you want dynamically using the scaling command

You have to scale back one node at a time waiting for the cluster to finish rebalancing
