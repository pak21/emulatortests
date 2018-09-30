#!/usr/bin/python3

import sys

from imagetotext import ImageToTextConverter
from pngparser import PngParser

p = PngParser()
c = ImageToTextConverter()

by_byte = p.parse(sys.argv[1])
characters = c.convert(by_byte)

print(characters)
