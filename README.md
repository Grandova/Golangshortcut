# Golangshortcut

Golang shortcut install with path

由于自己需要经常更换服务器安装 安装新的环境也很麻烦

自己弄了一个Go的快捷安装 此教程仅针对debian 11

替换debian 11系统源 并更新

`bash <(curl -Ls https://raw.githubusercontent.com/Grandova/Golangshortcut/main/replace.sh)`

安装Go 1.21.5 并添加环境变量

`bash <(curl -Ls https://raw.githubusercontent.com/Grandova/Golangshortcut/main/install.sh)`

刷新环境变量
`source /etc/profile`

上传到这里只是为了方便自己 有需要拿去用吧
