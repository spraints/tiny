FROM debian:jessie-slim

# Based on https://samuelhewitt.com/blog/2015-09-12-debian-linux-server-mac-os-time-machine-backups-how-to

RUN apt-get update && apt-get install -y \
  build-essential devscripts debhelper cdbs autotools-dev dh-buildinfo libdb-dev libwrap0-dev libpam0g-dev libcups2-dev libkrb5-dev libltdl3-dev libgcrypt11-dev libcrack2-dev libavahi-client-dev libldap2-dev libacl1-dev libevent-dev d-shlibs dh-systemd

RUN git clone https://github.com/adiknoth/netatalk-debian /src/netatalk-debian
WORKDIR /src/netatalk-debian
RUN git reset --hard 9b01f73a52121db90e32a05e2ce57bb0d5998e8f
RUN debuild -b -uc -us
RUN ls

RUN false
