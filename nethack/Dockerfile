FROM debian:stable-slim AS base

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf bison \
    bsdmainutils flex gcc git groff libncursesw5-dev libsqlite3-dev make \
    ncurses-dev sqlite3 tar telnetd-ssl xinetd locales curl && \
  apt-get clean

RUN locale-gen en_US.UTF-8

FROM base AS dgamelaunch
ARG DGAMELAUNCH_VERSION=f9bf041b50e00dda95b5b94031a457ff2b1cafd8
RUN curl -L https://github.com/paxed/dgamelaunch/archive/$DGAMELAUNCH_VERSION.tar.gz | \
  tar xfz - && \
  cd dgamelaunch-$DGAMELAUNCH_VERSION && \
  sed -i \
    -e "s/-lrt/-lrt -pthread/" \
    configure.ac && \
  ./autogen.sh \
    --enable-sqlite \
    --enable-shmem \
    --with-config-file=/opt/nethack/nethack.alt.org/etc/dgamelaunch.conf && \
  make && \
  ./dgl-create-chroot && \
  cd .. && \
  rm -rf dgamelaunch-$DGAMELAUNCH_VERSION

FROM base AS nethack361
# Current version at https://github.com/NetHack/NetHack/tree/NetHack-3.6.1_Release
COPY nh361hints /nh361hints
ARG NETHACK_VERSION=d4ebae12f1a709d1833cf466dd0c553fb97518d2
RUN curl -L https://github.com/NetHack/NetHack/archive/$NETHACK_VERSION.tar.gz | \
  tar xfz - && \
  cd NetHack-$NETHACK_VERSION/sys/unix && \
  mv /nh361hints hints/custom && \
  sh setup.sh hints/custom && \
  cd ../.. && \
  make all && \
  make install && \
  cd .. && \
  rm -rf NetHack-$NETHACK_VERSION

FROM base AS nethack343
RUN git clone https://alt.org/nethack/nh343-nao.git && \
  cd nh343-nao && \
  git reset --hard d643449940304015319bef4749c16c65c5141ee1 && \
  sed -i \
    -e "/^CFLAGS/s/-O/-O2 -fomit-frame-pointer/" \
    sys/unix/Makefile.src && \
  sed -i \
    -e "/rmdir \.\/-p/d" \
    sys/unix/Makefile.top && \
  sed -i \
    -e "/^CFLAGS/s/-O/-O2 -fomit-frame-pointer/" \
    sys/unix/Makefile.utl && \
  make all && \
  make install && \
  cd .. && \
  rm -rf nh343-nao

FROM dgamelaunch

COPY --from=nethack343 /opt/nethack/nethack.alt.org /opt/nethack/nethack.alt.org
COPY --from=nethack361 /opt/nethack/nethack.alt.org /opt/nethack/nethack.alt.org

RUN tar cf - \
  /lib/x86_64-linux-gnu/libncurses* \
  | tar xf - -C /opt/nethack/nethack.alt.org/

COPY dgamelaunch.conf /opt/nethack/nethack.alg.org/etc/dgamelaunch.conf
COPY dgl-xinetd.conf /etc/xinetd/dgl

VOLUME ["/opt/nethack/nethack.alt.org/nh343/var", "/opt/nethack/nethack.alt.org/dgldir"]

EXPOSE 23

CMD ["xinetd", "-dontfork"]
