#!/usr/bin/env python

import sys
import psutil


def get_cpu_load():
    print(psutil.cpu_percent(interval=2))


def get_memory_load():
    print(psutil.virtual_memory().percent)


def get_disk_load():
    print(psutil.disk_usage("/").percent)


if __name__ == "__main__":
    args = sys.argv
    globals()[args[1]](*args[2:])
