import colorsys
import pathlib


def render_palette(name, colors, bg='#ffffff', width=6):
  output = [f'{name}<br>']
  print(f'{name}:', end=' ')
  output.append(f'<div class="plate" style="background:{bg}">')
  for index, color in enumerate(colors):
    output.append(
        f'<div class="color" style="background:{color}">{color}</div>')
    print(f"'{color}',", end=' ')
    if width and (index + 1) % width == 0:
      output.append('<br>')
  output.append('</div>')
  output.append('<br>')
  print('')
  return output


def edit_palette_hsv(colors, hue_mult, sat_mult, val_mult):
  edited = []
  for color in colors:
    rgb = [int(color[i + 1: i + 3], 16) for i in (0, 2, 4)]
    hsv = list(colorsys.rgb_to_hsv(*rgb))
    hsv[0] *= hue_mult
    hsv[1] *= sat_mult
    hsv[2] *= val_mult
    rgb = [max(0, min(int(x), 255)) for x in colorsys.hsv_to_rgb(*hsv)]
    edited.append('#{0:02x}{1:02x}{2:02x}'.format(*rgb))
  return edited


output = ["""
<style>
body {
  color: #fff;
  background: #444;
  font-family: sans-serif;
  padding: 1em;
}
.plate {
  display: inline-block;
  padding: 1em;
  margin: .5em 0 2em;
  border-radius: .3em;
}
.color {
  display: inline-block;
  width: 5em;
  height: 5em;
  margin: .5em;
  text-align: center;
  line-height: 5em;
  border-radius: .3em;
}
.plate .color { color: transparent; transition: .1s color; }
.plate:hover .color { color: #fff; }
</style>
"""]

palette = [
    '#0044ff', '#88dd00', '#ff0011', '#ffbb00', '#cc44dd', '#00eeff',
    '#001177', '#117700', '#990022', '#885500', '#553366', '#006666',
]

# palette = [
#     '#0022ff', '#33aa00', '#ff0011', '#ddaa00', '#cc44dd', '#0088aa',
# ]

output += render_palette('Palette', palette, bg='#fff', width=6)
output += render_palette('Palette', palette, bg='#aaa', width=6)
output += render_palette('Palette', palette, bg='#666', width=6)
output += render_palette('Palette', palette, bg='#333', width=6)
output += render_palette('Palette', palette, bg='#000', width=6)

pathlib.Path('palette.html').write_text('\n'.join(output))
