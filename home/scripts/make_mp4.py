import argparse
import pathlib

import imageio
import numpy as np
from PIL import Image


def load_frames(inpath):
  print(f'Reading: {inpath}')
  if inpath.suffix == '.npz':
    return np.load(inpath)['image']
  else:
    return imageio.mimread(inpath)

def save_frames(outpath, frames, fps):
  print(f'Writing: {outpath}')
  imageio.mimsave(outpath, frames, fps=fps)

def resize_frames(frames, size):
  if frames[0].shape[:2] == size:
    return frames
  print(f'Resizing to {size[0]}x{size[1]}')
  return [resize_image(x, *size) for x in frames]

def resize_image(image, width, height):
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.array(image)

def main(args):
  frames = load_frames(args.inpath)
  frames = resize_frames(frames, args.size)
  save_frames(args.inpath.with_suffix('.mp4'), frames, args.fps)


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('inpath', type=pathlib.Path)
  parser.add_argument('--size', type=int, nargs=2, default=(256, 256))
  parser.add_argument('--fps', type=int, default=64)
  main(parser.parse_args())
