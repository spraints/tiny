# Zerotier

## Getting everything started

Build and run the ZT container. It'll use host networking and have admin access to them.

```
tiny$ ./start
```

If there are ZT networks already, remove them.

```
tiny$ ./controller list | xargs -n 1 -r ./controller delete
```

Create a new ZT network.

```
tiny$ nwid=$(./controller create --net $net --name zt.pickardayune.com | jq -r .nwid)
```

Create a file with a list of allowed hosts. It should look like this:

```
abc1234567 # optional description
7f7f7f6d6d
#6ab77e6e6e # not added
```

Add the current host and everything in the file to the new network.

```
tiny$ ./authorize-all $nwid network-hosts.txt
```

## Inspecting

```
tiny$ ./zerotier-cli status
tiny$ ./controller list
tiny$ ./controller ips "$(./controller list | head -n 1)"
tiny$ ./controller describe "$(./controller list | head -n 1)"
```
