import collections
import functools
import itertools
import json
import pathlib
import re

import gym
import imageio
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
import tensorflow_probability as tfp
import pandas as pd
from PIL import Image
from tensorflow_probability import distributions as tfd

random = np.random.RandomState(seed=0)

def flatten(sequence):
  return sum([list(x) for x in sequence], [])

def load_json(path):
  return json.loads(pathlib.Path(path).read_text())

def save_json(path, obj):
  return pathlib.Path(path).write_text(json.dumps(obj))

def resize_image(image, width, height):
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.array(image)

def render_video(inpath, outpath, size=256, fps=60):
  video = np.load(inpath)['image']
  video = [resize_image(x, size, size) for x in video]
  imageio.mimsave(outpath, video, fps=fps)