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

printf '===> Setting up docker apt source\n'
curl -fsSL https://download.docker.com/linux/debian/gpg | \
  apt-key add -

cat <<EOF > /etc/apt/sources.list.d/tiny.list
deb [arch=amd64] https://download.docker.com/linux/debian jessie stable
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

if [ "$(minikube version 2>/dev/null)" != "minikube version: v0.30.0" ]; then
  printf '===> Install minikube\n'
  minikube_url="https://github.com/kubernetes/minikube/releases/download/v0.30.0/minikube-linux-amd64"
  minikube_sha256sum="f6fcd916adbdabc84fceb4ff3cadd58586f0ef6e576233b1bd03ead1f8f04afa"
  rm -f /tmp/minikube
  curl -L "$minikube_url" -o /tmp/minikube
  if printf '%s %s\n' "$minikube_sha256sum" "/tmp/minikube" | sha256sum -c - >/dev/null; then
    chmod +x /tmp/minikube
    mv /tmp/minikube /usr/local/bin
  else
    echo Error downloading minikube
    exit 1
  fi
fi

echo '===> OK!'
