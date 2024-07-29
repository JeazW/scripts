#!/bin/bash

# 检查文件是否存在
if [ ! -f "ip.list" ]; then
    echo "Error: ip.list 文件不存在"
    exit 1
fi

# 从 ip.list 文件中读取 IP 地址列表
servers=$(cat ip.list)

# 循环遍历每个服务器
for server in $servers; do
    # 执行ping命令，发送4个数据包，设置超时时间为2秒
    ping -c 4 -W 2 $server > /dev/null 2>&1
    
    # 根据ping的返回值判断结果
    if [ $? -eq 0 ]; then
        echo "$server is up" >> ping_log.txt
    else
        echo "$server is down" >> ping_log.txt
    fi
done

