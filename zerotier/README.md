# Zerotier

## Starting

```
tiny$ ./start
```

## Inspecting

```
tiny$ docker exec -it zerotier /bin/bash
zerotier$ zerotier-cli info
```

## TODO

* Set up a controller on az vm.
* Set up a network for my stuff so that I can get to tiny at least from outside of home. I'll either need to add `--net=host` to the start script or figure out how to get the docker container set up with the right stuff so that I can ssh in or whatever.
* Run a moon on tiny so that clients on the network have a shorter path to each other? Maybe not.
