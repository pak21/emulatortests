class ImageToTextConverter:
    def _unscramble(self, scrambled):
        unscrambled = [None] * 192
        for third in range(0, 3):
            for character_row in range(0, 8):
                for pixel_row in range(0, 8):
                    input_row = 64 * third + 8 * pixel_row + character_row
                    input_offset = 32 * input_row
                    input_data = scrambled[input_offset:input_offset+32]
                    output_row = 64 * third + 8 * character_row + pixel_row
                    unscrambled[output_row] = input_data

        return unscrambled

    def _to_character_matrix(self, unscrambled):
        return [[[unscrambled[8 * row + pixel_row][column] for pixel_row in range(0, 8)] for column in range(0, 32)] for row in range(0, 24)]

    def _make_hash(self, character):
        character_hash = 0
        for pixel_row in character:
            character_hash *= 256
            character_hash += pixel_row
        return character_hash

    def _to_character_hashes(self, characters):
        return [[self._make_hash(c) for c in row] for row in characters]

    _known_hashes = {
            0: ' ',
            4521260801331200: '!',
            10172681580183552: '"',
            10271792857752576: '#',
            2320142374157832: '$',
            27694533511104000: '%',
            4547649521072640: '&',
            2269391999729664: '\'',
            1134730494346240: '(',
            9024860429754368: ')',
            22025633010688: '*',
            8831493474304: '+',
            526352: ',',
            1040187392: '-',
            1579008: '.',
            2216338399232: '/',
            16965783626333184: '0',
            6799414400663040: '1',
            16961075970866688: '2',
            16961117947575296: '3',
            2278361107662848: '4',
            35536748423560192: '5',
            16959401034398720: '6',
            35468063403937792: '7',
            16961325179747328: '8',
            16961350878247936: '9',
            68719480832: ':',
            17592187097120: ';',
            4432675210240: '<',
            266292035584: '=',
            17626613420032: '>',
            16961083684161536: '?',
            16970233411550208: '@',
            16961351956185600: 'A',
            34975998567152640: 'B',
            16961342326062080: 'C',
            33852048575592448: 'D',
            35536749463633408: 'E',
            35536749463617536: 'F',
            16961342560943104: 'G',
            18650458507854336: 'H',
            17460279143579136: 'I',
            565158678248448: 'J',
            19219945502294528: 'K',
            18085043209534976: 'L',
            18689886307631616: 'M',
            18685454035862016: 'N',
            16961350949551104: 'O',
            34975750431981568: 'P',
            16961351218510848: 'Q',
            34975750432244224: 'R',
            16959125082749952: 'S',
            71512305259515904: 'T',
            18650200809815040: 'U',
            18650200807839744: 'V',
            18650200811381760: 'W',
            18617034365747712: 'X',
            36666685831254016: 'Y',
            35470279742356992: 'Z',
            3949480261455360: '[',
            70506452091904: '\\',
            31542858566627328: ']',
            4565533325266944: '^',
            255: '_',
            7919198678318592: '£',
            61590842129408: 'a',
            9042641897536512: 'b',
            30924303506432: 'c',
            1130556796713984: 'd',
            61866726407168: 'e',
            3395395255275520: 'f',
            66263900226616: 'g',
            18085283795059712: 'h',
            4503806055299072: 'i',
            1125917154092056: 'j',
            9051386686219264: 'k',
            4521260802378752: 'l',
            114711401354240: 'm',
            132234598433792: 'n',
            61865854253056: 'o',
            132234601840704: 'p',
            66263900226566: 'q',
            30924303507456: 'r',
            61848468879360: 's',
            4565241267489792: 't',
            75059993786368: 'u',
            75059522179072: 'v',
            75128982743040: 'w',
            74938860454912: 'x',
            75059993248824: 'y',
            136374072146944: 'z',
            3949652060147200: '{',
            2260630401189888: '|',
            31542841386758144: '}',
            5673479999324160: '~',
            4342201910218539520: '©'
            }

    def find_character(self, h):
        try:
            c = self._known_hashes[h]
            return c
        except KeyError:
            return ' '

    def _to_characters(self, character_hashes):
        return [''.join([self.find_character(h) for h in row]) for row in character_hashes]

    def convert(self, scrambled_data):
        unscrambled_data = self._unscramble(scrambled_data)
        character_matrix = self._to_character_matrix(unscrambled_data)
        character_hashes = self._to_character_hashes(character_matrix)
        characters = self._to_characters(character_hashes)

        return characters
