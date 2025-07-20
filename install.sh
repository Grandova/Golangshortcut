#!/bin/bash

set -e  # 遇到错误就退出

# 确保是 root 运行
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[31m错误：必须使用 root 用户运行此脚本！\e[0m"
    exit 1
fi

# 配置
GO_VERSION=1.21.5
GO_TAR="go${GO_VERSION}.linux-amd64.tar.gz"
GO_URL="https://go.dev/dl/${GO_TAR}"
INSTALL_DIR=/usr/local
GO_ROOT=${INSTALL_DIR}/go
GO_PATH=/home/go

# 安装依赖
apt update && apt install -y wget tar git mercurial gcc curl

# 删除旧版本 Go
rm -rf "$GO_ROOT"

# 下载并解压 Go
echo "📦 正在下载 Go ${GO_VERSION}..."
wget -q --show-progress -P /tmp "$GO_URL"
tar -C "$INSTALL_DIR" -xzf "/tmp/${GO_TAR}"
rm -f "/tmp/${GO_TAR}"

# 创建 GOPATH 目录
mkdir -p "${GO_PATH}"/{bin,src,pkg}
chown -R "$SUDO_USER:$SUDO_USER" "$GO_PATH"

# 写入环境变量文件（永久有效）
cat <<EOF > /etc/profile.d/go.sh
export GOROOT=${GO_ROOT}
export GOPATH=${GO_PATH}
export PATH=\$GOROOT/bin:\$GOPATH/bin:\$PATH
EOF
chmod +x /etc/profile.d/go.sh

echo -e "\n✅ Go 安装完成！环境变量已写入 /etc/profile.d/go.sh"

# 提示用户使用新终端或手动 source
echo -e "\n📌 请执行以下命令使环境变量立刻生效："
echo -e "\e[32msource /etc/profile.d/go.sh\e[0m"
echo -e "或者重新连接 SSH 即可使用。\n"

# 展示版本信息
sleep 1
source /etc/profile.d/go.sh
go version
