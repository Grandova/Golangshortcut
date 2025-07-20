#!/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31m错误：必须使用 root 用户运行此脚本！\e[0m"
    exit 1
fi


GO_VERSION=go1.21.5.linux-amd64.tar.gz
INSTALL_DIR=/usr/local
GO_URL="https://go.dev/dl/${GO_VERSION}"
GO_ROOT=${INSTALL_DIR}/go
GO_PATH=/home/go


apt update && apt install -y mercurial git gcc wget tar


echo "正在下载 Go 安装包..."
wget -c -P "$INSTALL_DIR" "$GO_URL" || { echo "Go 下载失败！"; exit 1; }


cd "$INSTALL_DIR" || exit
tar -xzf "$GO_VERSION" || { echo "解压失败！"; exit 1; }
rm -f "$GO_VERSION"


mkdir -p "$GO_PATH"/{bin,src,pkg}


grep -q 'GOROOT=' /etc/profile || echo "export GOROOT=${GO_ROOT}" >> /etc/profile
grep -q 'GOPATH=' /etc/profile || echo "export GOPATH=${GO_PATH}" >> /etc/profile
grep -q '$GOROOT/bin' /etc/profile || echo 'export PATH=$GOROOT/bin:$PATH' >> /etc/profile

export GOROOT=${GO_ROOT}
export GOPATH=${GO_PATH}
export PATH=$GOROOT/bin:$PATH


echo "Go 版本："
go version || echo "Go 未正确安装！"
