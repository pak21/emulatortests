#!/usr/bin/python3

from imagetotext import ImageToTextConverter
from parser import Parser

class ScreenshotAnalyzer:
    fusetest_parsers = [
            ('^Frame length 0x8000 \+ (0x[0-9a-f]{4})', lambda m: 'Frame length', lambda m: 0x8000 + int(m[1], 16)),
            ('^Machine type: (.+?) *$', lambda m: 'Machine type', lambda m: m[1]),
            ('^Contention offset: (0x[0-9a-f]{2})', lambda m: 'Contention offset', lambda m: int(m[1], 16)),
            ('^(.+)\.\.\. (.+?) *$', lambda m: m[1], lambda m: m[2])
            ]

    z80test_parsers = [
            ('^([0-9]{3} .+?) *([A-Z]+)$', lambda m: m[1], lambda m: m[2]),
            ]

    parsers = {
            'fusetest': Parser(fusetest_parsers),
            'z80test': Parser(z80test_parsers)
            }

    converter = ImageToTextConverter()

    def analyze(self, filename, parser_key):
        with open(filename, 'rb') as f:
            scrambled = f.read()
        characters = self.converter.convert(scrambled)
        result = self.parsers[parser_key].parse(characters)

        return result
