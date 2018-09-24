import re

class Parser:
    def __init__(self, parsers):
        self.parsers = parsers

    def parse(self, characters):
        result = {}
        for line in characters:
            self._parse_line(line, result)

        return result

    def _parse_line(self, line, result):
        for regexp, namefn, resultfn in self.parsers:
            match = re.match(regexp, line)
            if match:
                result[namefn(match)] = resultfn(match)
