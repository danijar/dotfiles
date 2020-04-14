#!/usr/bin/python3

import json
import os
import sys

import sh

os.environ['PATH'] = os.environ['PATH'] + ':/usr/local/bin'
os.environ['PATH'] = os.environ['PATH'] + ':' + os.path.expanduser('~/homebrew/bin')

yabai = sh.Command('yabai').bake('-m')

# yabai.signal(
#     '--add',
#     'event=space_changed',
#     'label=bitbar_screens',
#     'action="open -g bitbar://refreshPlugin?name=yabai-screens.1s.sh"')

spaces = json.loads(str(yabai.query('--spaces')))
displays = sorted(set(space['display'] for space in spaces))
output = []
for display in displays:
  for space in spaces:
    if space['display'] != display:
      continue
    index = space['index']
    if space['focused']:
      output.append(f'[{index}]')
    elif space['windows']:
      output.append(f'({index})')
    else:
      output.append(f'.{index}.')
  output.append('  ')
print('' + ''.join(output) + '| font="andale mono"')

