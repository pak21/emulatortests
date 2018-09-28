#!/usr/bin/python3

import sys

import numpy as np
import png

from imagetotext import ImageToTextConverter

pixel_values = np.array(list(map(lambda x: 2**x, range(7, -1, -1))))

with open(sys.argv[1], 'rb') as f:
    reader = png.Reader(file=f)
    pngfile = reader.read()
    attributes = pngfile[3]
    if attributes['greyscale'] or attributes['bitdepth'] != 8 or attributes['interlace']:
        raise Exception('Nope, can\'t handle that PNG file. Sorry!')
    planes = attributes['planes']
    raw_image = np.vstack(pngfile[2])

# Take this image and convert it to a boolean array of pixels where True => set
reshaped_image = np.reshape(raw_image, newshape=(raw_image.shape[0], -1, planes))
# Remove any alpha channel if that existed
if planes == 4:
    reshaped_image = reshaped_image[:,:,:-1]
thresholded_image = (lambda x: x < 128)(reshaped_image)
pixel_image = np.all(thresholded_image, axis=2)

# Pad out to have a multiple of eight rows
if pixel_image.shape[0] % 8 != 0:
    rows_to_pad = 8 - (pixel_image.shape[0] % 8)
    pixel_image = np.pad(pixel_image, ((0, rows_to_pad), (0, 0)), 'constant')

# Now find the count of set pixels on each row, and roll up with a stride of 8
# The offset with the fewest pixels set is hopefully the top of the 8x8
# Spectrum character cells

set_pixels_per_row = np.sum(pixel_image, axis=1)
set_pixels_per_row_with_stride = np.sum(np.reshape(set_pixels_per_row, newshape=(-1, 8)), axis=0)
row_offset = np.argmin(set_pixels_per_row_with_stride)

# Ignore this bit for now :-)
set_pixels_per_column = np.sum(pixel_image, axis=0)
y1 = np.reshape(set_pixels_per_column, newshape=(-1, 8))
y2 = np.sum(y1, axis=0)

# We now need to delete row_offset rows from the top of the image, and
# (8 - row_offset) rows from the bottom to maintain our character squares

if row_offset != 0:
    rows_to_remove_at_bottom = 8 - row_offset
    pixel_image = pixel_image[row_offset:-rows_to_remove_at_bottom,:]

# Convert each sequence of 8 True/False values into a 0-255 value
by_character = np.reshape(pixel_image, newshape=(pixel_image.shape[0], -1, 8))
by_byte = np.apply_along_axis(arr=by_character, func1d=lambda pixels: np.dot(pixels, pixel_values), axis=2)

# Now group each 0-255 value into the vertical sets of 8 values which make up
# a character; the conversion to uint64 at the end is just to prevent integer
# overflows when making the hash values later
grouped_into_characters = np.reshape(np.transpose(by_byte), newshape=(by_byte.shape[1], -1, 8))
character_data = np.transpose(grouped_into_characters, axes=(1, 0, 2)).astype(np.uint64)

# Jam this into the middle of the image to text converter for now
c = ImageToTextConverter()
character_hashes = c._to_character_hashes(character_data)
characters = c._to_characters(character_hashes)

print(characters)
