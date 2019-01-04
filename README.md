# Cockroach Swarm

A container that properly* scales nodes respecting the docker swarm semantics

The swarm service must be named cockroachdb and must run within an overlay network

You can add as many node as you want dynamically using the scaling command

You have to scale back one node at a time waiting for the cluster to finish rebalancing

Also, there are currently loads issues with replicas on the same node in docker, so don't go over one replica per swarm node, even if it's cool for testing

## Usage:

    docker build https://github.com/LorenzoBoccaccia/cockroach-swarm.git -t tos/cockroachdb
    docker service create --replicas 1 --name cockroachdb --publish 8080:8080  --update-parallelism 1  --hostname "cockroachdb.{{.Task.Slot}}.{{.Task.ID}}" --network swarm-network --stop-grace-period 60s  tos/cockroachdb
    docker service scale cockroachdb=3
    

\* proper scaling depends on a number of features currently missing from cockroachdb, like decommissioning nodes
