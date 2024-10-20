import collections
import functools
import json
import pathlib
import re

import imageio
import numpy as np
import pandas as pd

random = np.random.default_rng(seed=0)

def resize(image, width, height):
  from PIL import Image
  image = Image.fromarray(image)
  image = image.resize((width, height), Image.NEAREST)
  return np.asarray(image)
