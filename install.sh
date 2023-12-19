#!/bin/bash
# check root
goversion=go1.21.5.linux-amd64.tar.gz
tar -zxvf=/usr/local/
[[ $EUID -ne 0 ]] && echo -e "${red}错误：${plain} 必须使用root用户运行此脚本！\n" && exit 1
apt install mercurial git gcc -y
wget -P ${installdir} https://go.dev/dl/${goversion}
cd ${installdir} && tar -zxvf ${goversion}
mkdir /home/go ; cd /home/go ; mkdir bin src pkg
echo "export GOROOT=/usr/local/go">>/etc/profile
echo "export PATH=$GOROOT/bin:$PATH">>/etc/profile
echo "export GOPATH=/home/go">>/etc/profile
source /etc/profile
go version
