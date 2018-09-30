#!/usr/bin/python3

import sys

import numpy as np
import png

from imagetotext import ImageToTextConverter
import pngparser

raw_image, attributes = pngparser.read(sys.argv[1])
pixel_image = pngparser.threshold_image(raw_image, attributes['planes'])
pixel_image = pngparser.pad_rows(pixel_image)
row_offset = pngparser.find_row_offset(pixel_image)
pixel_image = pngparser.apply_row_offset(pixel_image, row_offset)
by_byte = pngparser.to_bytes(pixel_image)

c = ImageToTextConverter()
characters = c.convert(by_byte)

print(characters)
