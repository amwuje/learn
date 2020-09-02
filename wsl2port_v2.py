# -*- coding: utf-8 -*-

import os
import subprocess

# 以管理员权限运行
def command(cmd, timeout=1800000):
    try:
        sp = subprocess.Popen(
            cmd,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print("[PID] %s: %s" % (sp.pid, cmd))
        sp.wait(timeout=timeout)

        stderr = str(sp.stderr.read().decode("gbk")).strip()
        stdout = str(sp.stdout.read().decode("gbk")).strip()
        if "" != stderr:
            raise Exception(stderr)
        if stdout.find("失败") > -1:
            raise Exception(stdout)
    except Exception as e:
        raise e

# 获得 ip 地址
ip_cmd = 'wsl ip a |wsl grep -w "inet" |wsl cut -d " " -f 6 |wsl cut -d "/" -f 1'
shells = os.popen(ip_cmd).readlines()
wsl_ip = shells[1].split("\n")[0]
print(wsl_ip)

# 用 WSL 的 root 重启 WSL 的 ssh 服务，WSL 的 bug
# ssh_res = 'wsl -u root service ssh --full-restart'
# shells = os.popen(ssh_res).readlines()
# print(shells)

addr = '0.0.0.0'
ports = '22'

# 解除 xx.xx.xx.xx(Windows IP) 的代理监听
del_listen = 'netsh interface portproxy delete v4tov4 listenaddress=' + addr + 'listenport=' + ports
command(del_listen,5)

# 将 xx.xx.xx.xx(Windows IP) 转发至 ubuntu(wsl IP) 的 xx 端口
add_listen = 'netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=222 connectaddress=ubuntu connectport=222'
command(add_listen,5)

# 显示代理监听
show_listen = 'netsh interface portproxy show all'
command(show_listen,5)
