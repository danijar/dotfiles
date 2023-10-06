import collections
import functools
import itertools
import json
import pathlib
import re

import imageio
import matplotlib.pyplot as plt
import numpy as np
import tensorflow_probability as tfp
import pandas as pd
from PIL import Image
from tensorflow_probability import distributions as tfd

random = np.random.RandomState(seed=0)

def load_json(path):
  return json.loads(pathlib.Path(path).read_text())

def save_json(path, obj):
  return pathlib.Path(path).write_text(json.dumps(obj))

def resize_image(image, width, height):
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.asarray(image)
