FROM debian:10.2

# This is needed for 'apt-key add'.
RUN apt-get update && apt-get install -y gnupg

COPY zerotier.list /etc/apt/sources.list.d/zerotier.list
COPY zerotier.key /tmp/zerotier.key
RUN apt-key add /tmp/zerotier.key

RUN apt-get update && apt-get install -y zerotier-one

VOLUME /var/lib/zerotier-one

ENTRYPOINT ["/usr/sbin/zerotier-one"]
