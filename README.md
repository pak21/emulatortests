# emulatortests

A simple tool for recording and analyzing the results of running some
test suites against Spectrum emulators.

## Usage

1. Find an emulator to test.
2. Run either [fusetest](https://sourceforge.net/p/fuse-emulator/code/HEAD/tree/trunk/fusetest/)
   or [z80test](http://zxds.raxoft.cz/taps/misc/z80test-1.0.zip).
3. Capture a .scr screenshot of every screen.
4. Put the screenshots into a `data/<emulator key>/<version key>/<testsuite key>`
   directory. Add emulators and versions into the database, test suites are
   defined in the `testsuites` table.
5. Run `emulatortests.py`.

## TODO

Oh so much. Some ideas:

* Work out the best way to host the already captured screenshots.
* Produce report showing results.
* Add more emulators and versions.
* Add the ability to parse PNG screenshots or something for emulators which
  can't output scr files.
* Add the ability to parse JPEGs or something for real machines / FPGA clones.
* Better documentation.

## Contact

Mail `philip-emulatortests@shadowmagic.org.uk`.
