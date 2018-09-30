# emulatortests

A simple tool for recording and analyzing the results of running some
test suites against Spectrum emulators.

## Usage

1. Find an emulator to test.
2. Run either [fusetest](https://sourceforge.net/p/fuse-emulator/code/HEAD/tree/trunk/fusetest/)
   or [z80test](http://zxds.raxoft.cz/taps/misc/z80test-1.0.zip).
3. Capture one of the following formats for every screen (most preferred at top):
    1. An .scr screenshot
    2. A 256x192 .png of the Spectrum's screen
    3. A capture of the emulator's window with the Spectrum's screen at 256x192 resolution.
4. Put the screenshots into a `data/<emulator key>/<version key>/<testsuite key>`
   directory. Add emulators and versions into the database, test suites are
   defined in the `testsuites` table.
5. Run `emulatortests.py`.

## TODO

Oh so much. Some ideas:

* Work out the best way to host the already captured screenshots.
* Produce report showing results.
* Add more emulators and versions.
* Add the ability to parse JPEGs or something for real machines / FPGA clones.
* Better documentation.

## Contact

Mail `philip-emulatortests@shadowmagic.org.uk`.
