# !/usr/bin/python3
# coding: utf-8
import os
import subprocess
import traceback


def runAdmin(cmd, timeout=1800000):
    f = None
    try:
        bat = os.getcwd() + r"\script\cmd.bat"
        f = open(bat, 'w')
        f.write(cmd)
    except Exception as e:
        traceback.print_exc()
        raise e
    finally:
        if f:
            f.close()

    try:
        shell = os.getcwd() + r"\script\shell.vbs"
        sp = subprocess.Popen(
            shell,
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
ports = 'any'

# 解除 xx.xx.xx.xx(Windows IP) 的代理监听
del_listen = 'netsh interface portproxy delete v4tov4 listenaddress=' + addr + \
    ' listenport=' + ports
runAdmin(del_listen)

# 将 xx.xx.xx.xx(Windows IP) 转发至 ubuntu(wsl IP) 的 xx 端口
add_listen = 'netsh interface portproxy add v4tov4 listenaddress=' + \
    addr + ' listenport=' + ports + ' connectaddress=' + \
    wsl_ip + ' connectport=' + ports
runAdmin(add_listen)

# 显示代理监听
show_listen = 'netsh interface portproxy show all'
runAdmin(show_listen)

