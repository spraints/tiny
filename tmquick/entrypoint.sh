#!/bin/bash

mkdir -p /data/timemachine
chown -R timemachine:timemachine /data/timemachine

exec netatalk -d
