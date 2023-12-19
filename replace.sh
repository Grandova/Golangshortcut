#!/bin/bash
mv /etc/apt/sources.list /etc/apt/sources.list.backup
wget -P /etc/apt/ https://raw.githubusercontent.com/Grandova/golangshortcut/main/sources.list
apt update -y ; apt upgrade -y
