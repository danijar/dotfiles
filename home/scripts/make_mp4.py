import argparse
import pathlib

import imageio
import numpy as np
from PIL import Image


def resize_image(image, size):
  if image.shape[:2] == size:
    return image
  image = Image.fromarray(image)
  image = image.resize(size, Image.NEAREST)
  return np.array(image)


def main(args):
  if args.inpath.suffix == '.npz':
    frames = np.load(args.inpath)['image']
  else:
    frames = imageio.get_reader(args.inpath)

  # outpath = args.inpath.with_suffix('.out.gif')
  # writer = imageio.get_writer(outpath, fps=args.fps, mode='I', loop=0)

  outpath = args.inpath.with_suffix('.mp4')
  writer = imageio.get_writer(outpath, fps=args.fps)

  for index, frame in enumerate(frames):

    # if index >= len(frames) - 10:
    #   break

    frame = frame[..., :3]
    if index % 100 == 0:
      print('.', end='', flush=True)
    height = int(args.zoom * frame.shape[0])
    width = int(args.zoom * frame.shape[1])
    frame = resize_image(frame, (width, height))
    writer.append_data(frame)

  writer.close()
  print('\nDone')


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('inpath', type=pathlib.Path)
  parser.add_argument('--zoom', type=float, default=4.0)
  parser.add_argument('--fps', type=int, default=30)
  main(parser.parse_args())
