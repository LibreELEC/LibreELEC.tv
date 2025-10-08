#!/usr/bin/env python

# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

# disables pylint checks for:
# variable/function naming convention
# lack of docstring to start module
# line length check
# pylint: disable=C0103,C0114,C0301


import json
import urllib.request

from datetime import datetime, timedelta


class UpdateSystem():
    '''Functions to check for, and validate system updates.'''
    def __init__(self, force_update=False, json_url=None, json_data=None, nightly=False, verbose=False):
        # information on running system
        self.current = {
            'architecture': None,
            'distribution': None,
            'version': None,
            'version_id': None,
            'version_major': None,
            'version_minor': None,
            'version_bugfix': None,
            'timestamp': None
            }
        # information on proposed update
        self.candidate = {
            'canarydate': None,
            'filename': None,
            'sha256': None,
            'subpath': None,
            'timestamp': None,
            'url': None,
            'version_major': None,
            'version_minor': None,
            'version_bugfix': None
            }
        # releases.json
        self.json_url = json_url
        self.update_json = json_data
        # update results
        self.abort_check = False
        self.abort_canary = False
        self.update_available = False
        self.update_major = False
        self.update_url = None
        # general
        self.force_update = force_update
        self.nightly = nightly
        self.verbose = verbose


    @staticmethod
    def get_highest_value(values):
        '''Review list of integers (that are internally strings, like releases) and return highest as string.'''
        highest_value = 0 # releases start at 0
        for value in values:
            value = int(value)
            highest_value = max(value, highest_value)
        return str(highest_value)


    def parse_osrelease(self):
        '''Read /etc/os-release and set corresponding variables.'''
        with open('/etc/os-release', mode='r', encoding='utf-8') as data:
            content = data.read()
        for line in content.splitlines():
            if line[0:12] == 'DISTRO_ARCH=':
                self.current['architecture'] = line.split('=')[1].strip('\"')
            elif line[0:5] == 'NAME=':
                self.current['distribution'] = line.split('=')[1].strip('\"')
            elif line[0:8] == 'VERSION=':
                self.current['version'] = line.split('=')[1].strip('\"')
            elif line[0:11] == 'VERSION_ID=':
                self.current['version_id'] = line.split('=')[1].strip('\"')
            if self.current['architecture'] and self.current['distribution'] and self.current['version'] and self.current['version_id']:
                break
        # If debugging other devices, change self.current[architecture, distribution, version, version_id] here
        self.current['version_major'], self.current['version_minor'] = [int(i) for i in self.current['version_id'].split('.')]
        self.current['version_bugfix'] = int(self.current['version'].split('.')[2]) if not self.current['version'].startswith(('devel', 'nightly')) else None
        if self.current['version'].startswith('nightly'):
            self.current['timestamp'] = datetime.strptime(self.current['version'].split('-')[1], '%Y%m%d')
        elif self.current['version'].startswith('devel'):
            self.current['timestamp'] = datetime.strptime(self.current['version'].split('-')[1], '%Y%m%d%H%M%S')
        else:
            # TODO only place available is stable releases.json. this is only used when we're downloading the test json instead. Timestamp of a file on disk available instead?
            self.current['timestamp'] = None


    def fetch_update_json(self):
        '''Downloads releases.json file and readies for parsing.'''
        try:
            with urllib.request.urlopen(self.json_url) as data:
                self.update_json = json.loads(data.read().decode('utf-8').strip()) if data else None
        except urllib.error.HTTPError as err:
            if err.code == 404:
                print(f'ERROR: HTTP 404: Failed to download from: {self.json_url}')
                raise
            else:
                print(f'ERROR: Unhandled HTTPError: {err=}')
                raise


    def parse_device_json(self, device_json, canary=None):
        '''Parse json fields of a device's release entry.'''
        if self.nightly:
            if 'image' in device_json: # image entry
                self.candidate['filename'] = device_json['image']['name']
                self.candidate['sha256'] = device_json['image']['sha256']
                self.candidate['subpath'] = device_json['image']['subpath']
                self.candidate['timestamp'] = datetime.strptime(device_json['image']['timestamp'], '%Y-%m-%d %H:%M:%S')
            else: # uboot entry
                self.candidate['filename'] = device_json['uboot'][0]['name']
                self.candidate['sha256'] = device_json['uboot'][0]['sha256']
                self.candidate['subpath'] = device_json['uboot'][0]['subpath']
                self.candidate['timestamp'] = datetime.strptime(device_json['uboot'][0]['timestamp'], '%Y-%m-%d %H:%M:%S')
        else: # file entry
            self.candidate['filename'] = device_json['file']['name']
            # Assumes filename format is 'distribution-device.arch-version.tar'
            self.candidate['sha256'] = device_json['file']['sha256']
            self.candidate['subpath'] = device_json['file']['subpath']
            self.candidate['timestamp'] = datetime.strptime(device_json['file']['timestamp'], '%Y-%m-%d %H:%M:%S')
        version = tuple(int(i) for i in self.candidate['filename'].split('-')[-1].removesuffix('.tar').split('.')) if not 'devel' in self.candidate['filename'] and not 'nightly' in self.candidate['filename'] else (None, None, None)
        self.candidate['version_major'] = version[0]
        self.candidate['version_minor'] = version[1]
        self.candidate['version_bugfix'] = version[2]
        # set if parts are known and not nightly check
        self.candidate['canarydate'] = self.candidate['timestamp'] + timedelta(days=canary) if self.candidate['timestamp'] and canary and not self.nightly else None


    def abort_update_check(self, msg='abort_update_check() triggered'):
        '''Reset update result flags to None.'''
        print(msg)
        self.update_available = False
        self.update_major = False
        self.update_url = None


    def precheck_update(self):
        '''Gather and validate information needed for update check.'''
        self.parse_osrelease()
        if self.verbose:
            print(f'{self.current["architecture"]=}\n{self.current["distribution"]=}\n{self.current["version"]=}\n{self.current["version_id"]=}')
        if not (self.current['architecture'] and self.current['distribution'] and self.current['version'] and self.current['version_id']):
            self.abort_update_check('ERROR: parse_osrelease failed. Unable to determine running device or version.')
            self.abort_check = True
            return

        # Retrieve json with release data
        if not self.update_json:
            self.fetch_update_json()
        if not self.update_json:
            self.abort_update_check('ERROR: Failed to load json release data.')
            self.abort_check = True
            return


    def check_for_bugfix(self):
        '''Review releases.json for bugfix update.'''
        self.precheck_update()
        if self.abort_check:
            return

        release_branch = f'{self.current["distribution"]}-{self.current["version_id"]}'
        if release_branch not in self.update_json:
            self.abort_update_check('Running release branch not in json file.')
            return
        device_release = UpdateSystem.get_highest_value(self.update_json[release_branch]['project'][self.current['architecture']]['releases'])
        release_canary = self.update_json[release_branch]['canary']
        # Parses highest (most recent) release of device within releases.json file
        self.parse_device_json(self.update_json[release_branch]['project'][self.current['architecture']]['releases'][device_release], release_canary)

        # Higher bugfix release or stable release after running nightly available
        # 'is not None' is on purpose - '0' is valid but evals to Falsey
        if (self.current['version_bugfix'] is not None and self.candidate['version_bugfix'] > self.current['version_bugfix']) or (self.candidate['timestamp'] and self.current['timestamp'] and self.candidate['timestamp'] > self.current['timestamp']):
            self.candidate['url'] = self.update_json[release_branch]['url']
            self.update_url = f'{self.candidate["url"]}{self.candidate["subpath"]}/{self.candidate["filename"]}'
            if self.force_update or (self.candidate['canarydate'] and datetime.now() > self.candidate['canarydate']):
                self.update_available = True
                return
            self.abort_canary = True
            self.abort_update_check()
            return


    def check_for_major(self):
        '''Review releases.json for major update.'''
        self.precheck_update()
        if self.abort_check:
            return

        # Check for major system updates
        highest_version_major = self.current['version_major']
        highest_version_minor = self.current['version_minor']
        # Highest release branch for architecture
        for os_branch in self.update_json:
            key_version_major, key_version_minor = [int(i) for i in os_branch.removeprefix(f'{self.current["distribution"]}-').split('.')]
            if ((key_version_major > highest_version_major or
                    (key_version_major == highest_version_major and key_version_minor > highest_version_minor)) and
                    self.current['architecture'] in self.update_json[os_branch]['project']):
                highest_version_major = key_version_major
                highest_version_minor = key_version_minor
        # Test if release series changed
        if highest_version_major == self.current['version_major'] and highest_version_minor == self.current['version_minor']:
            self.update_available = False
            self.update_major = False
            return

        release_branch = f'{self.current["distribution"]}-{highest_version_major}.{highest_version_minor}'
        # determine latest release for device
        device_release = UpdateSystem.get_highest_value(self.update_json[release_branch]['project'][self.current['architecture']]['releases'])
        release_canary = self.update_json[release_branch]['canary']
        # Parses highest (most recent) release of device within releases.json file
        self.parse_device_json(self.update_json[release_branch]['project'][self.current['architecture']]['releases'][device_release], release_canary)

        # Major or minor version update
        if self.candidate['version_major'] > self.current['version_major'] or \
                (self.candidate['version_major'] == self.current['version_major'] and self.candidate['version_minor'] > self.current['version_minor']):

            self.candidate['url'] = self.update_json[release_branch]['url']
            self.update_url = f'{self.candidate["url"]}{self.candidate["subpath"]}/{self.candidate["filename"]}'
            self.update_available = True
            self.update_major = True
            return


    def check_for_nightly(self):
        '''Review test build's releases.json for updates to running release series.'''
        self.precheck_update()
        if self.abort_check:
            return

        release_branch = f'{self.current["distribution"]}-{self.current["version_id"]}'
        if release_branch not in self.update_json:
            self.abort_update_check('Running release branch not in json file.')
            return

        device_release = UpdateSystem.get_highest_value(self.update_json[release_branch]['project'][self.current['architecture']]['releases'])
        # Parses highest (most recent) release of device within releases.json file
        self.parse_device_json(self.update_json[release_branch]['project'][self.current['architecture']]['releases'][device_release])

        # compare timestamps to determine newer
        if self.candidate['timestamp'] and self.current['timestamp']:
            if self.candidate['timestamp'] > self.current['timestamp']:
                self.candidate['url'] = self.update_json[release_branch]['url']
                self.update_url = f'{self.candidate["url"]}{self.candidate["subpath"]}/{self.candidate["filename"]}' if self.candidate['subpath'] else f'{self.candidate["url"]}{self.candidate["filename"]}'
                self.update_available = True
                return
            else:
                self.abort_update_check(msg='Running build newer than available nightlies.')
                return
        else:
            self.abort_update_check()
            return
