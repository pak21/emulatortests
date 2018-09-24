#!/usr/bin/python3

import collections
import contextlib
from glob import glob
import mysql.connector as mariadb
import os

from screenshotanalyzer import ScreenshotAnalyzer

def find_emulator(emulator_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id, name FROM emulators WHERE `key` = %s', (emulator_key,))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find emulator with key {}".format(emulator_key))
        return rows[0]

def find_version(emulator_id, version_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id, version FROM emulator_versions WHERE emulator_id = %s AND `key` = %s', (emulator_id, version_key))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find emulator version for emulator {} with key {}".format(emulator_id, version_key))
        return rows[0]

def find_testsuite(testsuite_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id, name, parser FROM testsuites WHERE `key` = %s', (testsuite_key,))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find testsuite with key {}".format(testsuite_key))
        return rows[0]

def merge_results(old, new):
    merged = old.copy()
    for k, v in new.items():
        if k in old:
            if old[k] != v:
                raise Exception('Inconsistent results for {}: old {}, new {}'.format(k, old[k], v))
        else:
            merged[k] = v

    return merged

DATA_DIR = 'data'

database_password = os.environ['DATABASE_PASSWORD']
conn = mariadb.connect(database='emulator_tests', user='philip', password=database_password)

analyzer = ScreenshotAnalyzer()
results = collections.defaultdict(lambda: collections.defaultdict(lambda: collections.defaultdict(lambda: {})))

for emulator_dir in glob(os.path.join(DATA_DIR, '*')):
    emulator_key = os.path.basename(emulator_dir)
    emulator_id, emulator_name = find_emulator(emulator_key)
    for version_dir in glob(os.path.join(emulator_dir, '*')):
        version_key = os.path.basename(version_dir)
        version_id, version_name = find_version(emulator_id, version_key)
        for testsuite_dir in glob(os.path.join(version_dir, '*')):
            testsuite_key = os.path.basename(testsuite_dir)
            testsuite_id, testsuite_name, testsuite_parser = find_testsuite(testsuite_key)
            for datafile in glob(os.path.join(testsuite_dir, '*.scr')):
                result = analyzer.analyze(datafile, testsuite_parser)

                version_results = results[emulator_key][version_key]

                testsuite_results = version_results[testsuite_key]
                merged_results = merge_results(testsuite_results, result)
                version_results[testsuite_key] = merged_results

print(results)
