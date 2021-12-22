import argparse
import pathlib

import imageio
import numpy as np
from PIL import Image


def resize_image(image, width, height):
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.array(image)


def main(args):
  outpath = args.inpath.with_suffix('.mp4')
  print(f'Reading: {args.inpath}')
  frames = imageio.mimread(args.inpath)
  print(f'Resizing to {args.size}')
  frames = [resize_image(x, *args.size) for x in frames]
  print(f'Writing: {outpath}')
  imageio.mimsave(outpath, frames, fps=args.fps)


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('inpath', type=pathlib.Path)
  parser.add_argument('--size', type=int, nargs=2, default=(256, 256))
  parser.add_argument('--fps', type=int, default=64)
  main(parser.parse_args())
