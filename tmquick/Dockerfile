FROM debian:jessie-slim

# Based on https://samuelhewitt.com/blog/2015-09-12-debian-linux-server-mac-os-time-machine-backups-how-to

RUN apt-get update && apt-get install -y \
  build-essential devscripts debhelper cdbs autotools-dev dh-buildinfo libdb-dev libwrap0-dev libpam0g-dev libcups2-dev libkrb5-dev libltdl3-dev libgcrypt11-dev libcrack2-dev libavahi-client-dev libldap2-dev libacl1-dev libevent-dev d-shlibs dh-systemd
RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/adiknoth/netatalk-debian /src/netatalk-debian
WORKDIR /src/netatalk-debian
RUN git reset --hard 9b01f73a52121db90e32a05e2ce57bb0d5998e8f
RUN debuild -b -uc -us

FROM debian:jessie-slim

RUN apt-get update && apt-get install -y \
	libacl1 libattr1 libc6 libcrack2 libldap-2.4-2 libwrap0 \
	libavahi-client3 libavahi-common3 libcomerr2 libdb5.3 libevent-2.0-5 libgcrypt20 libgssapi-krb5-2 libk5crypto3 libkrb5-3 libpam0g perl init-system-helpers netbase libpam-modules python


COPY --from=0 /src/libatalk18_3.1.11-1_amd64.deb /
COPY --from=0 /src/netatalk_3.1.11-1_amd64.deb /

RUN dpkg -i /libatalk18_3.1.11-1_amd64.deb
RUN dpkg -i /netatalk_3.1.11-1_amd64.deb

RUN groupadd --gid 2000 timemachine
RUN useradd --uid 2000 --gid 2000 --home-dir /data/timemachine timemachine
# /data/timemachine gets created in the entrypoint, so that it can be set up on a mounted volume.

COPY afp.conf /etc/netatalk/afp.conf

COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint
ENTRYPOINT ["/entrypoint"]
