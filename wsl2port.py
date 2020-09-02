# -*- coding: utf-8 -*-

import os
# 获得 ip 地址
ip_cmd = 'wsl ip a |wsl grep -w "inet" |wsl cut -d " " -f 6 |wsl cut -d "/" -f 1'
shells = os.popen(ip_cmd).readlines()
wsl_ip = shells[1].split("\n")[0]
print(wsl_ip)

# 写入 Windows hosts 文件
file_path = "C:/Windows/System32/drivers/etc/hosts"
with open(file_path, "r") as f:
    lines = f.readlines()

found = False
# 查找 hostname 为 ubuntu 的行
for i, line in enumerate(lines):
    if len(line) > 10 and line.find("ubuntu") > -1:
        found = True
        # 替换为当前的 ip
        lines[i] = wsl_ip + "  ubuntu"
        print(lines[i])
        break

# 没有hostname 为 ubuntu 的行
if not found:
    lines.append("\n" + wsl_ip + "  ubuntu")

# 写入文件
if lines:
    with open(file_path, "w") as f:
        f.write("".join(lines))


ssh_res = 'wsl -u root service ssh --full-restart'
del_listen = 'netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0  listenport=22'
add_listen = 'netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 \
            listenport=22 connectaddress=ubuntu connectport=22'
show_listen = 'netsh interface portproxy show all'

shells = os.popen(ssh_res).readlines()
print(shells)

shells = os.popen(del_listen).readlines()
print(shells)

shells = os.popen(add_listen).readlines()
print(shells)

shells = os.popen(show_listen).readlines()
print(shells)
