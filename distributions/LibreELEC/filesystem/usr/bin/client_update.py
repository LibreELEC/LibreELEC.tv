#!/usr/bin/env python

# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

# disables pylint checks for:
# variable/function naming convention
# lack of docstring to start module
# line length check
# pylint: disable=C0103,C0114,C0301


import argparse
import importlib.machinery
import importlib.util
import os
import shutil
import sys
import tempfile
import urllib.request

from hashlib import sha256

def import_from_file(module_name, file_path):
    '''Import python source code module from file path.'''
    if os.path.isfile(file_path) and module_name not in sys.modules:
        spec = importlib.util.spec_from_loader(
            module_name,
            importlib.machinery.SourceFileLoader(module_name, file_path)
            )
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        sys.modules[module_name] = module
        return module
    elif module_name in sys.modules:
        print(f'Module already loaded: {module_name}')
    else:
        print(f'File not found: {file_path}')

update_lib = import_from_file(module_name='update_lib', file_path='/usr/lib/libreelec/update_lib.py')


def fetch_update_file(url, sha256sum, file_name, update_dir='/storage/.update'):
    '''Download update_url to a temporary directory. Copy to update directory when finished.'''
    def get_sha256_hash(file_path):
        '''Calculate sha256 sum of file_path in 8KiB chunks.'''
        with open(file_path, mode='rb') as file:
            sha256hash = sha256()
            while True:
                data_block = file.read(8192)
                if not data_block:
                    break
                sha256hash.update(data_block)
        return sha256hash.hexdigest()

    download_sha256sum = None
    with tempfile.TemporaryDirectory() as update_temp_dir:
        try:
            with urllib.request.urlopen(url) as download, open(f'{update_temp_dir}/update.file', mode='wb') as file_in_progress:
                shutil.copyfileobj(download, file_in_progress)
        except Exception as e:
            print(e)
            # delete partial download
            if os.path.isfile(f'{update_temp_dir}/update.file'):
                print('ERROR: Download failure. Deleting partially downloaded file.')
                os.remove(f'{update_temp_dir}/update.file')
        else:
            print('Download finished.')
            if os.path.isfile(f'{update_temp_dir}/update.file'):
                download_sha256sum = get_sha256_hash(f'{update_temp_dir}/update.file')
                if args.verbose:
                    print(f'{sha256sum=}\n{download_sha256sum=}')
                if sha256sum == download_sha256sum:
                    print(f'Copying {file_name} to {update_dir}')
                    shutil.copy2(f'{update_temp_dir}/update.file', f'{update_dir}/{file_name}')
                else:
                    print(f'ERROR: sha256 checksum failure.\n  Wanted: {sha256sum}\n  Downloaded: {download_sha256sum}')
                    print('  Deleting downloaded file.')
                    os.remove(f'{update_temp_dir}/update.file')
    if os.path.isfile(f'{update_dir}/{client_update.candidate["filename"]}'):
        print('Download complete. Reboot to continue the update.')
    else:
        print('Download failed. Please try again later.')


if __name__ == '__main__':
    # parse CLI arguments
    parser = argparse.ArgumentParser(description='Parse releases.json for suitable update files.', argument_default=False)
    parser.add_argument('-v', '--verbose', default=False,
        help = 'Verbose output', action = 'store_true')
    parser.add_argument('-b', '--bugfix', default=False,
        help = 'Check for bugfix updates only (ex 12.0.x -> 12.0.y).', action = 'store_true')
    parser.add_argument('-m', '--major', default=False,
        help = 'Check for major/minor updates only (ex 12.x -> 13.x).', action = 'store_true')
    parser.add_argument('-n', '--nightly', default=False,
        help = 'Check for newer nightly test build. Only works if already running a test or development build.', action = 'store_true')
    parser.add_argument('-f', '--force', default=False,
        help = 'Ignore testing periods for updates.', action = 'store_true')
    parser.add_argument('-j', '--json', default=None,
        help = 'http or file path to an alternative releases.json file.', action = 'store')
    parser.add_argument('-u', '--update', default=False,
        help = 'Download update file for latest minor bugfix release, if available.', action = 'store_true')
    args = parser.parse_args()

    # sanity check
    if args.nightly and (args.bugfix or args.major):
        print('Error: --nightly may not be combined with --bugfix or --major. Assuming --nightly intended.')
        args.bugfix = False
        args.major = False

    if args.json:
        if args.json.startswith(('http://', 'https://')):
            releases_json = args.json
        elif os.path.isfile(os.path.join(os.getcwd(), args.json)):
            releases_json = f'file://{os.path.join(os.getcwd(), args.json)}'
        else:
            print(f'ERROR: Unable to locate: {args.json}')
            sys.exit(1)
    elif args.nightly:
        releases_json = 'https://test.libreelec.tv/releases.json'
    else:
        releases_json = 'https://releases.libreelec.tv/releases.json'

    client_update = update_lib.UpdateSystem(json_url=releases_json, json_data=None, nightly=args.nightly, verbose=args.verbose)

    if args.bugfix:
        client_update.check_for_bugfix()
    elif args.major:
        client_update.check_for_major()
    elif args.nightly:
        client_update.check_for_nightly()
    else:
        client_update.check_for_bugfix()
        if not client_update.update_available:
            client_update.check_for_major()
    if args.verbose:
        print(f'{client_update.update_available=}\n{client_update.update_major=}\n{client_update.update_url=}')

    if client_update.update_available:
        print(f'Found update file: {client_update.update_url}')
        if client_update.update_major:
            print('Major system update found. See https://libreelec.tv for release notes.')
        else:
            if args.update:
                print(f'Downloading: {client_update.update_url}')
                fetch_update_file(url=client_update.update_url, sha256sum=client_update.candidate['sha256'], file_name=client_update.candidate['filename'])
            else:
                print('System update found. Run command again with --update to apply.')
    else:
        print('No eligible system updates found to apply.')
