#!/bin/bash
# This assumes an ssh-server debian jessie install.
#
# Run this as root or with sudo.

set -e
set -o nounset

toinstall=
for pkg in
  avahi-daemon
  libnss-mdns
do
  if dpkg -l "$pkg" | grep ^ii >&/dev/null; then
    toinstall="$toinstall $pkg"
  fi
done

if [ -n "$toinstall" ]; then
  set -x
  apt-get update
  apt-get install -y $toinstall
fi
