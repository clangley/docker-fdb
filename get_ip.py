#!/usr/bin/python3
import os
import socket

def get_env_name(env=None):
    if env == None:
        name = socket.gethostname() + "-0"
        env = name.replace("-0", "").replace("-", "_").replace(".", "_").upper()
    return f"{env}_SERVICE_HOST"

def get_ip(env=None):
    name = get_env_name(env)
    return os.environ[name]

print(get_ip())