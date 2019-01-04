# Cockroach Swarm

A container that scales nodes respecting the docker swarm semantics instead of having to start nodes one by one

The swarm service must be named cockroachdb and must run within an overlay network

You can add as many node as you want dynamically using the scaling command

You have to scale back one node at a time waiting for the cluster to finish rebalancing

Also, there are currently loads issues with replicas on the same node in docker, so don't go over one replica per swarm node, even if it's cool for testing

## Usage:

    docker build https://github.com/LorenzoBoccaccia/cockroach-swarm.git -t tos/cockroachdb
    sudo docker network create --driver overlay --attachable cockroachdb
    docker service create --replicas 3 --name cockroachdb --publish 8080:8080  --update-parallelism 1  --hostname "cockroachdb.{{.Task.Slot}}.{{.Task.ID}}" --network swarm-network --stop-grace-period 60s  tos/cockroachdb

You can use your own name for the network but cockroachdb service name is hardcoded internally for discoverability


## Attach a client:

     docker run --network swarm-network -it tos/cockroachdb cockroach sql --host=cockroachdb --insecure




    

