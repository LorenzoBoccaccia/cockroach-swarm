# Cockroach Swarm

A container that scales nodes respecting the docker swarm semantics instead of having to start nodes one by one

The swarm service must be named cockroachdb, it's essential for discoverability of nodes; you cna pick whatever network name you like and it's not necessary for it to be attachable like in the example below.

You can add as many node as you want dynamically using the standard swarm scaling command, and you can scale them back as easily, an interrupt trap decommission the node properly.

## Usage:

    docker build https://github.com/LorenzoBoccaccia/cockroach-swarm.git -t tos/cockroachdb
    sudo docker network create --driver overlay --attachable cockroachdb
    docker service create --replicas 3 --name cockroachdb --publish 8080:8080  --update-parallelism 1  --hostname "cockroachdb.{{.Task.Slot}}.{{.Task.ID}}" --network swarm-network --stop-grace-period 60s  tos/cockroachdb



## Attach a client:

     docker run --network swarm-network -it tos/cockroachdb cockroach sql --host=cockroachdb --insecure


## TODO

    Figure a way to use node label to configure cockroach zones.

    

