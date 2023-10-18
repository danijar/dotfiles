import json
import pathlib
import re
from collections import defaultdict, deque
from functools import partial as bind

import imageio
import numpy as np
import pandas as pd
from PIL import Image
from tensorflow_probability import distributions as tfd

random = np.random.default_rng(seed=0)

def load_json(path):
  return json.loads(pathlib.Path(path).read_text())

def save_json(path, data):
  return pathlib.Path(path).write_text(json.dumps(dataobj))

def resize_image(image, width, height):
  from PIL import Image
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.asarray(image)
