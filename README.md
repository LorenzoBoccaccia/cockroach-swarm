# Cockroach Swarm

A container that properly* scales nodes respecting the docker swarm semantics

The swarm service must be named cockroachdb and must run within an overlay network

You can add as many node as you want dynamically using the scaling command

You have to scale back one node at a time waiting for the cluster to finish rebalancing

## Usage:

    docker build https://github.com/LorenzoBoccaccia/cockroach-swarm.git -t tos/cockroachdb
    docker service create --name cockroachdb --replicas 5  -e NUM_REPLICAS3=3 --network swarm-network --mount type=volume,source=cockroachdb{{.Task.Slot}},destination=/cockroach-data  tos/cockroachdb
    

\* proper scaling depends on a number of features currently missing from cockroachdb, like decommissioning nodes
