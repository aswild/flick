#!/usr/bin/env python3

import argparse
from dataclasses import dataclass
import math
import os
import sys

from PIL import Image

file_header = """\
/*
 * Adafruit_GFX compatible bitmap converted from {input} using img2gfxbitmap.py
 */

"""

def log(*args):
    print(*args, file=sys.stderr)

def preprocess_image(im):
    if im.mode != '1':
        log(f'Converting image from mode {im.mode} to monochrome')
        im = im.convert(mode='1', dither='NONE')

    bounding_box = im.getbbox()
    log(f'Bounding box is {bounding_box}')
    im = im.crop(bounding_box)
    log(f'Cropped to {im.size}')

    return im

def image_to_array(im):
    # Image format: one bit per pixel, packed MSB first.
    # Each row is zero-padded to a full number of bytes
    bytes_per_row = math.ceil(im.width / 8)
    last_col_bits = im.width % 8
    data = []
    for row in range(im.height):
        # for each complete byte in the row
        for byte in range(im.width // 8):
            #breakpoint()
            val = 0
            for bit in range(8):
                col = (byte * 8) + bit
                pixel = im.getpixel((col, row))
                if pixel:
                    val |= 1 << (7 - bit)
            data.append(val)
        # handle last byte padded byte in row
        if last_col_bits:
            val = 0
            for bit in range(last_col_bits):
                col = (8 * (im.width // 8)) + bit
                pixel = im.getpixel((col, row))
                if pixel:
                    val |= 1 << (7 - bit)
            data.append(val)

    return data

def write_image_code(im, name, input_name, out):
    data = image_to_array(im)

    out.write(file_header.format(input=input_name))
    out.write(f'static const int16_t {name}_width = {im.width};\n')
    out.write(f'static const int16_t {name}_height = {im.height};\n')
    out.write('\n')
    out.write(f'static const uint8_t {name}_data[] = ')
    out.write('{\n    ') # un-confuse vim's indentation

    for (i, b) in enumerate(data):
        if i and i % 16 == 0:
            out.write('\n    ')
        out.write(f'0x{b:02x}, ')

    out.write('\n};\n')

    # sanity check, recalculate size for good measure
    total_bytes = im.height * math.ceil(im.width / 8)
    out.write(f'static_assert(sizeof({name}_data) == (({name}_width + 7) / 8) * {name}_height);\n')

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--name', help='variable name to define')
    parser.add_argument('input', help='input file')
    parser.add_argument('output', nargs='?', help='output file (omit for stdout)')
    args = parser.parse_args()

    im = Image.open(args.input)
    log(f'Loaded image, size {im.size}')
    log('Preprocessing image')
    im = preprocess_image(im)

    if args.output is None:
        out = sys.stdout
        log('Writing to stdout')
    else:
        out = open(args.output, 'w')
        log(f'Writing to file {args.output}')

    if args.name is not None:
        name = args.name
    else:
        name = os.path.splitext(os.path.basename(args.input))[0]

    write_image_code(im, name, args.input, out)

if __name__ == '__main__':
    sys.exit(main())
