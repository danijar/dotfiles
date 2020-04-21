import argparse
import pathlib


def split_events(content):
  events = []
  event = None
  for line in content.split('\n'):
    if line == 'BEGIN:VEVENT':
      event = []
    if line == 'END:VEVENT':
      event.append(line)
      events.append(event)
      event = None
    if event is not None:
      event.append(line)
  return events


def merge_line_breaks(lines):
  results = []
  for line in lines:
    if ':' in line:
      results.append(line)
    else:
      results[-1] += line.strip()
  return results


def format_csv(mappings):
  # keys = sorted(set(sum([list(x.keys()) for x in mappings], [])))
  keys = 'start', 'end', 'name'
  lines = [','.join(keys)]
  quote = lambda s: "'" + s + "'" if ' ' in s else s
  for mapping in mappings:
    lines.append(','.join(quote(mapping[key]) for key in keys))
  return '\n'.join(lines) + '\n'


def main(args):
  content = args.input.read_text()
  events = split_events(content)
  merged = [merge_line_breaks(lines) for lines in events]
  decoded = [[line.replace('\\', '') for line in event] for event in merged]
  mappings = [{l.split(':', 1)[0]: l.split(':', 1)[1] for l in e} for e in decoded]
  keys = {'DTSTART;VALUE=DATE': 'start', 'DTEND;VALUE=DATE': 'end', 'SUMMARY': 'name'}
  filtered = [{keys[k]:v for k,v in event.items() if k in keys} for event in mappings]
  output = format_csv(filtered)
  args.output.write_text(output)


def parse_args():
  parser = argparse.ArgumentParser()
  parser.add_argument('input', type=pathlib.Path)
  parser.add_argument('output', type=pathlib.Path)
  args = parser.parse_args()
  assert args.input.suffix == '.ics'
  assert args.output.suffix == '.csv'
  return args


if __name__ == '__main__':
  main(parse_args())
