#!/usr/bin/python3

import sys

import numpy as np
import png

pixel_values = np.array(list(map(lambda x: 2**x, range(7, -1, -1))))

def read(filename):
    with open(filename, 'rb') as f:
        reader = png.Reader(file=f)
        pngfile = reader.read()
        attributes = pngfile[3]
        if attributes['greyscale'] or attributes['bitdepth'] != 8 or attributes['interlace']:
            raise Exception('Can\'t handle a PNG file with attributes {}. Sorry!'.format(attributes))
        planes = attributes['planes']
        return np.vstack(pngfile[2]), attributes

def threshold_image(raw_image, planes):
    # Take this image and convert it to a boolean array of pixels where True => set
    reshaped_image = np.reshape(raw_image, newshape=(raw_image.shape[0], -1, planes))
    # Remove any alpha channel if that existed
    if planes == 4:
        reshaped_image = reshaped_image[:,:,:-1]
    thresholded_image = reshaped_image < 128
    return np.all(thresholded_image, axis=2)

def pad_rows(pixel_image):
    # Pad out to have a multiple of eight rows
    if pixel_image.shape[0] % 8 != 0:
        rows_to_pad = 8 - (pixel_image.shape[0] % 8)
        pixel_image = np.pad(pixel_image, ((0, rows_to_pad), (0, 0)), 'constant')

    return pixel_image

def find_row_offset(pixel_image):
    # Now find the count of set pixels on each row, and roll up with a stride of 8
    # The offset with the fewest pixels set is hopefully the top of the 8x8
    # Spectrum character cells
    set_pixels_per_row = np.sum(pixel_image, axis=1)
    set_pixels_per_row_with_stride = np.sum(np.reshape(set_pixels_per_row, newshape=(-1, 8)), axis=0)
    return np.argmin(set_pixels_per_row_with_stride)

def apply_row_offset(pixel_image, row_offset):
    # We now need to delete row_offset rows from the top of the image, and
    # (8 - row_offset) rows from the bottom to maintain our character squares
    if row_offset != 0:
        rows_to_remove_at_bottom = 8 - row_offset
        pixel_image = pixel_image[row_offset:-rows_to_remove_at_bottom,:]

    return pixel_image

def to_bytes(pixel_image):
    # Convert each sequence of 8 True/False values into a 0-255 value
    by_character = np.reshape(pixel_image, newshape=(pixel_image.shape[0], -1, 8))
    return np.apply_along_axis(arr=by_character, func1d=lambda pixels: np.dot(pixels, pixel_values), axis=2)

if __name__ == '__main__':

    # Ignore this bit for now :-)
    set_pixels_per_column = np.sum(pixel_image, axis=0)
    y1 = np.reshape(set_pixels_per_column, newshape=(-1, 8))
    y2 = np.sum(y1, axis=0)
