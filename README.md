<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Dockerized-pulse](#dockerized-pulse)
  - [Tips](#tips)
  - [Install](#install)
  - [Manual](#manual)
  - [Thanks to](#thanks-to)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Dockerized-pulse

A dockerized version of the pulse secure VPN

## Tips

You can chose you Docker image OS by selecting the branch.
The pattern is `image/<OS>` :

- `image/debian` : should contain Debian based container
- `image/debian` : should contain Fedora based container
- `image/ubuntu` : should contain Ubuntu based container

## Install

You can simply run the following to use the default and lightest image (Debian as of now) :

```bash
git clone git@github.com:hypr2771/pulsed.git && \
    cd pulsed && \
    docker build . -t pulse --build-arg VPN_URL="<VPN_URL>" --build-arg VPN_DESCRIPTION="<VPN_DESCRIPTION>" --build-arg AV_SERVICE="<AV_SERVICE>" && \
    echo -e '[Desktop Entry]\nversion=1.0\nType=Application\nExec=xhost local:root; sh -c "docker run --privileged --rm --net=host --volume=\"$HOME/.Xauthority:/root/.Xauthority:rw\" --env=\"DISPLAY=$DISPLAY\" pulse"\nTerminal=false\nName=Dockerized Pulse Secure\nComment=Dockerized Pulse Secure VPN client\nIcon=network-workgroup' > ~/.local/share/applications/dockerized-pulse.desktop && \
    chmod +x ~/.local/share/applications/dockerized-pulse.desktop
```

With :

- `VPN_URL` being your Secure Pulse form URL
- `VPN_DESCRIPTION` being your label for Secure Pulse app
- `AV_SERVICE` being your Antivirus service to mock

> :warning: `YOUR_VPN_NAME` should not contain white spaces characters for now !

Running this script will create a "Dockerized Pulse Secure" application in your Application menu.
You can then simply run this application to connect to Pulse !

## Manual

Clone the repository :

```bash
git clone git@github.com:hypr2771/pulsed.git
```

then choose your Docker image :

```bash
git checkout image/<OS>
```

```bash
docker build pulsed --no-cache -t pulse --build-arg VPN_URL="<VPN_URL>" --build-arg VPN_DESCRIPTION="<VPN_DESCRIPTION>" --build-arg AV_SERVICE="<AV_SERVICE>"
```

With :

- `VPN_URL` being your Secure Pulse form URL
- `VPN_DESCRIPTION` being your label for Secure Pulse app
- `AV_SERVICE` being your Antivirus service to mock

Then simply run :

```bash
docker run -it --privileged --rm --net=host --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --env="DISPLAY=$DISPLAY" pulse
```

The volume and environment variables are needed for the app to be displayed outside of the container.
You may need to allow connection to the display by running the following on your machine :

```bash
xhost local:root
```

Enjoy!

## Thanks to

[@TheBatman09](https://github.com/TheBatman09) for the whole Dockerfile and the `DISPLAY` configuration
