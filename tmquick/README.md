# Tmquick

Sets tiny up to be a target for Time Machine backups from macOS. I think I've tried this with Catalina.

I wanted to set this up in a container, but wasn't able to figure out how to get avahi-daemon to work in a container and on the host.

## Usage

* `tmquick/build` - builds debs
* `tmquick/install` - installs the debs, and their dependencies, set up timemachine user and its directory

Future:
* https://alexlubbock.com/time-machine-network-backup-linux
