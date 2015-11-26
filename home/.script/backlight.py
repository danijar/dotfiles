#!/bin/python3

import os
import subprocess
import sys


STEPS = 10
POWER = 2.5
FILENAME = os.path.basename(__file__)
USAGE = """usage: ./{} <command>

Changes the backlight brightness in a non-linear way to have finer control in
the low brightness and more notable changes in high brightness. Requires
xbacklight to be installed.

These are the available commands:
  up       Increase the backlight brightness
  down     Decrease the backlight brightness""".format(FILENAME)


def clamp(value, min_=1, max_=100):
    # Clamp between bounds and round to nearest integer.
    value = min(max(min_, value), max_)
    value = int(round(value, 0))
    return value


def read():
    external = float(subprocess.check_output(['xbacklight']))
    external = clamp(external)
    # Convert to internal linear scale
    value = 100 * (external / 100) ** (1 / POWER)
    value = clamp(value)
    return value


def write(value):
    value = clamp(value)
    # Convert to external non-linear scale
    external = 100 * (value / 100) ** POWER
    external = clamp(external)
    return subprocess.run(['xbacklight', '-set', str(external)], check=True)


if __name__ == '__main__':
    if len(sys.argv) == 2 and sys.argv[1] == 'up':
        value = read() + (100 / STEPS)
    elif len(sys.argv) == 2 and sys.argv[1] == 'down':
        value = read() - (100 / STEPS)
    else:
        print(USAGE)
        sys.exit(1)
    write(value)
