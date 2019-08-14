FROM debian:stable-slim

RUN apt-get update && apt-get install -y apt-cacher-ng

VOLUME /var/cache/apt-cacher-ng

ENTRYPOINT [ \
  "/usr/sbin/apt-cacher-ng", \
  "-c", "/etc/apt-cacher-ng", \
  "Port=3142", \
  "BindAddress=0.0.0.0", \
  "Foreground=1" \
]
