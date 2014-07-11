#!/bin/sh

SERVER_PORT=$1
EXTRA_ARGS=$2
INITD=/usr/local/etc/init.d/docker

# docker binary must be available under /usr/bin/ or else Vagrant tries
# to install docker which fails on the boot2docker VM.
echo "---> Make docker binary available under /usr/bin/"
sudo ln -sf /usr/local/bin/docker /usr/bin/docker

# boot2docker has a problem with dns startup.
# For more info look at issue #357 on github/boot2docker
echo "---> Fix dns problems by restarting udhcpc and docker"
sudo udhcpc
sudo ${INITD} restart

if [ ${SERVER_PORT} -ne "2735" ]; then
  echo "---> Configuring docker to listen on port ${SERVER_PORT} and restarting"
  sudo sed -i -e 's|\\(DOCKER_HOST="-H tcp://0.0.0.0:\\)2735|\\1${SERVER_PORT}|' ${INITD}
  sudo ${INITD} restart
fi

if [ -n "${EXTRA_ARGS}" ]; then
  echo "---> Configuring docker with args '${EXTRA_ARGS}' and restarting"
  echo "${EXTRA_ARGS}" > /var/lib/boot2docker/profile
  sudo ${INITD} restart
fi
