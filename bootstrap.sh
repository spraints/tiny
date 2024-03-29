#!/bin/bash
# This assumes an ssh-server debian jessie install.
#
# Run this as root or with sudo.

set -e
set -o nounset

install_missing() {
  local missing=
  for pkg; do
    if ! dpkg -l "$pkg" | grep ^ii >&/dev/null; then
      missing="$missing $pkg"
    fi
  done
  if [ -n "$missing" ]; then
    printf '===> Installing missing packages %s\n' "$missing"
    apt-get update
    apt-get install -y $missing
  fi
}

install_missing \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

printf '===> Setting up extra apt sources\n'
curl -fsSL https://download.docker.com/linux/debian/gpg | \
  apt-key add -

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
  apt-key add -

cat <<EOF > /etc/apt/sources.list.d/tiny.list
deb [arch=amd64] https://download.docker.com/linux/debian jessie stable
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

install_missing \
  avahi-daemon \
  libnss-mdns \
  docker-ce

if ! docker-compose --version | grep ^docker-compose >&/dev/null; then
  printf '===> Install docker-compose\n'
  docker_compose_url="https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)"
  rm -f /tmp/docker-compose
  curl -L "$docker_compose_url" -o /tmp/docker-compose
  chmod +x /tmp/docker-compose
  if /tmp/docker-compose --version | grep ^docker-compose >&/dev/null; then
    mv /tmp/docker-compose /usr/local/bin/
  else
    echo Error downloading docker-compose
    exit 1
  fi
fi

echo '===> OK!'
