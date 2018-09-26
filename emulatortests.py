#!/usr/bin/python3

import collections
import contextlib
from glob import glob
import mysql.connector as mariadb
import os

from screenshotanalyzer import ScreenshotAnalyzer

def find_emulator(emulator_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id FROM emulators WHERE `key` = %s', (emulator_key,))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find emulator with key {}".format(emulator_key))
        return rows[0][0]

def find_version(emulator_id, version_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id FROM emulator_versions WHERE emulator_id = %s AND `key` = %s', (emulator_id, version_key))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find emulator version for emulator {} with key {}".format(emulator_id, version_key))
        return rows[0][0]

def find_testsuite(testsuite_key):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id, parser FROM testsuites WHERE `key` = %s', (testsuite_key,))
        rows = cursor.fetchall()
        if len(rows) != 1:
            raise Exception("Couldn't find testsuite with key {}".format(testsuite_key))
        return rows[0]

def get_all_tests():
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT id, testsuite_id, name FROM tests')
        return cursor.fetchall()

def get_results(version_id, testsuite_id):
    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute('SELECT test_id, result FROM results JOIN tests ON results.test_id = tests.id WHERE results.emulator_version_id = %s AND tests.testsuite_id = %s', (version_id, testsuite_id))
        rows = cursor.fetchall()
        return dict(rows)

def parse_emulator(emulator_dir):
    emulator_key = os.path.basename(emulator_dir)
    emulator_id = find_emulator(emulator_key)
    for version_dir in glob(os.path.join(emulator_dir, '*')):
        parse_emulator_version(version_dir, emulator_id)

def parse_emulator_version(version_dir, emulator_id):
    version_key = os.path.basename(version_dir)
    version_id = find_version(emulator_id, version_key)
    for testsuite_dir in glob(os.path.join(version_dir, '*')):
        parse_testsuite(testsuite_dir, version_id)

def write_new_results(results_to_write, version_id):
    tuples_to_write = [(version_id, test_id, test_result) for test_id, test_result in results_to_write.items()]
    values_to_write = tuple([item for t in tuples_to_write for item in t])

    placeholders = ','.join(['(%s,%s,%s)'] * len(results_to_write))
    sql = 'INSERT INTO results (emulator_version_id, test_id, result) VALUES {}'.format(placeholders)

    with contextlib.closing(conn.cursor()) as cursor:
        cursor.execute(sql, values_to_write)
        conn.commit()

def find_new_results_and_write(results, version_id, testsuite_id):
    results_by_id = {tests_cache[(testsuite_id, k)]: v for k, v in results.items()}
    old_results = get_results(version_id, testsuite_id)

    results_to_write = {}
    for k, v in results_by_id.items():
        if k in old_results:
            if old_results[k] != v:
                raise Exception('New result "{}" for {} does not match old result "{}"'.format(v, k, old_results[k]))
            # If the values were equal, don't need to make any changes
        else:
            # If the value didn't exist in the old results, this is a new result so add it
            results_to_write[k] = v

    if results_to_write:
        write_new_results(results_to_write, version_id)

def parse_testsuite(testsuite_dir, version_id):
    testsuite_key = os.path.basename(testsuite_dir)
    testsuite_id, testsuite_parser = find_testsuite(testsuite_key)

    results = {}
    for datafile in glob(os.path.join(testsuite_dir, '*.scr')):
        results = parse_screenshot(results, datafile, testsuite_parser)

    if results:
        find_new_results_and_write(results, version_id, testsuite_id)

def parse_screenshot(results, datafile, testsuite_parser):
    result = analyzer.analyze(datafile, testsuite_parser)
    return merge_results(results, result)

def merge_results(old, new):
    merged = old.copy()
    for k, v in new.items():
        if k in old:
            if old[k] != v:
                raise Exception('Inconsistent results for {}: old "{}", new "{}"'.format(k, old[k], v))
        else:
            merged[k] = v

    return merged

DATA_DIR = 'data'

database_password = os.environ['DATABASE_PASSWORD']
conn = mariadb.connect(database='emulator_tests', user='philip', password=database_password)

analyzer = ScreenshotAnalyzer()

tests_cache = {(testsuite_id, name): test_id for test_id, testsuite_id, name in get_all_tests()}

for emulator_dir in glob(os.path.join(DATA_DIR, '*')):
    parse_emulator(emulator_dir)
