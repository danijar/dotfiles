import argparse
import pathlib

import einops
import imageio
import numpy as np
import tqdm
from PIL import Image


def main(args):

  R, C = args.grid
  assert all(0 <= row < R for row in args.rows)
  assert all(0 <= col < C for col in args.cols)

  kw = {}
  if args.opath.suffix == '.gif':
    kw.update(mode='I', loop=0)

  reader = imageio.get_reader(args.ipath)
  writer = imageio.get_writer(args.opath, fps=args.fps, **kw)

  for index, frame in enumerate(tqdm.tqdm(reader, total=-1)):

    frame = frame[..., :3]

    if args.trim:
      start, stop = args.trim
      start *= args.fps
      stop *= args.fps
      if start > 0 and index < start:
        continue
      if stop > 0 and index >= stop:
        break

    if args.grid != (1, 1):
      H, W = frame.shape[:2]
      frame = frame[:H - (H % R), :][:, :W - (W % C)]
      frame = einops.rearrange(frame, '(r h) (c w) d -> r c h w d', r=R, c=C)
      frame = frame[args.rows, :][:, args.cols]
      frame = einops.rearrange(frame, 'r c h w d -> (r h) (c w) d')

    if args.zoom != 1:
      size = [int(x * args.zoom) for x in frame.shape[:2]]
      frame = np.asarray(Image.fromarray(frame).resize(size, Image.NEAREST))

    writer.append_data(frame)

  writer.close()
  print('Written:', args.opath)


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument('ipath', type=pathlib.Path)
  parser.add_argument('opath', type=pathlib.Path)
  parser.add_argument('--fps', type=int, default=10)
  parser.add_argument('--zoom', type=float, default=1.0)
  parser.add_argument('--trim', type=int, nargs=2, default=None)
  parser.add_argument('--grid', type=int, nargs=2, default=(1, 1))
  parser.add_argument('--cols', type=int, nargs='+', default=(0,))
  parser.add_argument('--rows', type=int, nargs='+', default=(0,))
  main(parser.parse_args())
