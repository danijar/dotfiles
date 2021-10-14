#!/usr/bin/python3

import json
import os
import sys

os.environ['PATH'] += ':/usr/local/bin'
os.environ['PATH'] += ':' + os.path.expanduser('~/homebrew/bin')
os.environ['PATH'] += ':' + os.path.expanduser('~/homebrew/sbin')

spaces = json.loads(os.popen('yabai -m query --spaces').read())
displays = sorted(set(space['display'] for space in spaces))
output = []
for display in displays:
  for space in spaces:
    if space['display'] != display:
      continue
    index = space['index']
    if space['focused']:
      output.append(f'>{index} ')
    elif space['windows']:
      output.append(f':{index} ')
    else:
      output.append(f' {index} ')
print('' + ''.join(output) + '| font="andale mono"')

