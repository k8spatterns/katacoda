#!/bin/sh
bat_version=0.12.1
curl -L -o /tmp/bat.deb https://github.com/sharkdp/bat/releases/download/v${bat_version}/bat_${bat_version}_amd64.deb
dpkg -i /tmp/bat.deb
rm /tmp/bat.deb

launch-kubernetes.sh
