#!/bin/bash
# This assumes an ssh-server debian jessie install.
#
# Run this as root or with sudo.

apt-get update
apt-get install -y avahi-daemon libnss-mdns
