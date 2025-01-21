#! /usr/bin/env python3

#SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Ian Leonard (antonlacon@gmail.com)

'''
This generates a list of URLs of every file used by the selected image build.

The script may be invoked like so:

./genmirrorlist.py --all

This considers every project/device/arch/uboot_system in builds_all.

./genmirrorlist.py --builddirs

This filters --all's build list to only ones with a build directory.

PROJECT=W DEVICE=X ARCH=Y UBOOT_SYSTEM=Z ./genmirrorlist.py

This runs against the project/device/arch specificed on the CLI.

For working with multiple git branches (different versions), there are
additional options:

--export filename to write a list of packages and their source tarballs to
file.

./genmirror.py --all --export file1.txt
'''


import argparse
import os
import subprocess
import shutil
import sys


DISTRO_NAME = 'LibreELEC'


# project, device, arch, uboot_system
builds_all = [
    ['Allwinner', 'A64', 'aarch64', 'oranagepi-win'],
    ['Allwinner', 'A64', 'aarch64', 'pine64'],
    ['Allwinner', 'A64', 'aarch64', 'pine64-lts'],
    ['Allwinner', 'A64', 'aarch64', 'pine64-plus'],
    ['Allwinner', 'H3', 'arm', 'banana-m2p'],
    ['Allwinner', 'H3', 'arm', 'beelink-x2'],
    ['Allwinner', 'H3', 'arm', 'libretech-h3'],
    ['Allwinner', 'H3', 'arm', 'nanopi-m1'],
    ['Allwinner', 'H3', 'arm', 'orangepi-2'],
    ['Allwinner', 'H3', 'arm', 'orangepi-pc'],
    ['Allwinner', 'H3', 'arm', 'orangepi-pc-plus'],
    ['Allwinner', 'H3', 'arm', 'orangepi-pc-plus2e'],
    ['Allwinner', 'H5', 'aarch64', 'tritium-h5'],
    ['Allwinner', 'H6', 'aarch64', 'beelink-gs1'],
    ['Allwinner', 'H6', 'aarch64', 'orangepi-3'],
    ['Allwinner', 'H6', 'aarch64', 'orangepi-3-lts'],
    ['Allwinner', 'H6', 'aarch64', 'oranagepi-lite2'],
    ['Allwinner', 'H6', 'aarch64', 'orangepi-one-plus'],
    ['Allwinner', 'H6', 'aarch64', 'pine-h64'],
    ['Allwinner', 'H6', 'aarch64', 'pine-h64-model-b'],
    ['Allwinner', 'H6', 'aarch64', 'tanix-tx6'],
    ['Allwinner', 'R40', 'arm', 'banana-m2u'],
    ['Amlogic', 'AMLGX', 'aarch64', 'bananapi-m2-pro'],
    ['Amlogic', 'AMLGX', 'aarch64', 'bananapi-m2s'],
    ['Amlogic', 'AMLGX', 'aarch64', 'bananapi-m5'],
    ['Amlogic', 'AMLGX', 'aarch64', 'box'],
    ['Amlogic', 'AMLGX', 'aarch64', 'khadas-vim'],
    ['Amlogic', 'AMLGX', 'aarch64', 'khadas-vim2'],
    ['Amlogic', 'AMLGX', 'aarch64', 'khadas-vim3'],
    ['Amlogic', 'AMLGX', 'aarch64', 'khadas-vim3l'],
    ['Amlogic', 'AMLGX', 'aarch64', 'lafrite'],
    ['Amlogic', 'AMLGX', 'aarch64', 'lepotato'],
    ['Amlogic', 'AMLGX', 'aarch64', 'nanopi-k2'],
    ['Amlogic', 'AMLGX', 'aarch64', 'odroid-c2'],
    ['Amlogic', 'AMLGX', 'aarch64', 'odroid-c4'],
    ['Amlogic', 'AMLGX', 'aarch64', 'odroid-hc4'],
    ['Amlogic', 'AMLGX', 'aarch64', 'odroid-n2'],
    ['Amlogic', 'AMLGX', 'aarch64', 'radxa-zero'],
    ['Amlogic', 'AMLGX', 'aarch64', 'radxa-zero2'],
    ['Amlogic', 'AMLGX', 'aarch64', 'wetek-core2'],
    ['Amlogic', 'AMLGX', 'arm', 'wetek-hub'],
    ['Amlogic', 'AMLGX', 'aarch64', 'wetek-play2'],
    ['Generic', 'Generic', 'x86_64', None],
    ['Generic', 'Generic-legacy', 'x86_64', None],
    ['NXP', 'iMX6', 'arm', 'cubox'],
    ['NXP', 'iMX6', 'arm', 'udoo'],
    ['NXP', 'iMX6', 'arm', 'wandboard'],
    ['NXP', 'iMX8', 'aarch64', 'mq-evk'],
    ['NXP', 'iMX8', 'aarch64', 'pico-mq'],
    ['Qualcomm', 'Dragonboard', 'aarch64', '410c'],
    ['RPi', 'RPi2', 'arm', None],
    ['RPi', 'RPi4', 'aarch64', None],
    ['RPi', 'RPi5', 'aarch64', None],
    ['Samsung', 'Exynos', 'arm', 'odroid-xu3'],
    ['Samsung', 'Exynos', 'arm', 'odroid-xu4'],
    ['Rockchip', 'RK3288', 'arm', 'miqi'],
    ['Rockchip', 'RK3288', 'arm', 'tinker'],
    ['Rockchip', 'RK3328', 'aarch64', 'a1'],
    ['Rockchip', 'RK3328', 'aarch64', 'roc-cc'],
    ['Rockchip', 'RK3328', 'aarch64', 'rock64'],
    ['Rockchip', 'RK3399', 'aarch64', 'hugsun-x99'],
    ['Rockchip', 'RK3399', 'aarch64', 'khadas-edge'],
    ['Rockchip', 'RK3399', 'aarch64', 'nanopc-t4'],
    ['Rockchip', 'RK3399', 'aarch64', 'nanopi-m4'],
    ['Rockchip', 'RK3399', 'aarch64', 'orangepi'],
    ['Rockchip', 'RK3399', 'aarch64', 'roc-pc'],
    ['Rockchip', 'RK3399', 'aarch64', 'roc-pc-plus'],
    ['Rockchip', 'RK3399', 'aarch64', 'rock-pi-4'],
    ['Rockchip', 'RK3399', 'aarch64', 'rock-pi-4-plus'],
    ['Rockchip', 'RK3399', 'aarch64', 'rock-pi-n10'],
    ['Rockchip', 'RK3399', 'aarch64', 'rock960'],
    ['Rockchip', 'RK3399', 'aarch64', 'rockpro64'],
    ['Rockchip', 'RK3399', 'aarch64', 'sapphire'],
]
# no test builds
#    ['RPi', 'RPi', 'arm', None],


def execute(command):
    '''Run shell commands.'''
    try:
        cmd_status = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f'Command failed: {command}')
        print(f'Executed command: {e.cmd}')
        print(f'START COMMAND OUTPUT:\n{e.stdout.decode()}\nEND COMMAND OUTPUT')
        return None
    return cmd_status.stdout.decode()


def parse_distro_info():
    '''Read distro settings from file.'''
    le_version = None
    os_version = None
    with open(f'{os.getcwd()}/distributions/{DISTRO_NAME}/version', mode='r', encoding='utf-8') as data:
        content = data.read()
    for line in content.splitlines():
        line = line.strip()
        if line[0:17] == 'LIBREELEC_VERSION':
            le_version = line.split('=')[1].strip('\"')
        elif line[0:10] == 'OS_VERSION':
            os_version = line.split('=')[1].strip('\"')
        if le_version and os_version:
            break
    return le_version, os_version


# build list of packages with desired versions to keep
def get_git_packagelist():
    '''Create list of packages, their source package filenames, and URL to download for every setup in builds'''
    if args.all or args.builddirs:
        builds = builds_all
    else:
        project = os.getenv('PROJECT')
        device = os.getenv('DEVICE')
        arch = os.getenv('ARCH')
        uboot_system = os.getenv('UBOOT_SYSTEM') if os.getenv('UBOOT_SYSTEM') else None
        if project and device and arch:
            builds = [[project, device, arch, uboot_system]]
        else:
            print('Error: Unkown build. Set PROJECT, DEVICE, ARCH and, if needed, UBOOT_SYSTEM or invoke with --all')
            sys.exit(1)
    pkg_list = []

    if args.builddirs:
        le_version, os_version = parse_distro_info()
    for build in builds:
        # skip entries from builds_all if not build directory present for it
        if args.builddirs and not os.path.isdir(f'{os.getcwd()}/build.{DISTRO_NAME}-{build[1]}.{build[2]}-{os_version}-{le_version}'):
            continue
        # build list of packages that go into each build
        cmd_build = f'PROJECT={build[0]} DEVICE={build[1]} ARCH={build[2]}'
        if build[3]:
            cmd_build = f'{cmd_build} UBOOT_SYSTEM={build[3]}'
        cmd_buildplan = f'{cmd_build} scripts/pkgjson | scripts/genbuildplan.py --hide-header --list-packages --build image'
        cmd_result = execute(f'{cmd_buildplan}')
        if cmd_result:
            for item in cmd_result.splitlines():
                pkg_url = None
                # get package details
                pkg_details = execute(f'{cmd_build} tools/pkginfo --strip {item}').strip()
                for line in pkg_details.splitlines():
                    if line.startswith('PKG_URL'):
                        pkg_url = line.split('=')[-1].strip('"')
                        break
                # add package and filename to master list if not present
                if pkg_url and [item, pkg_url] not in pkg_list:
                    pkg_list.append([item, pkg_url])
    return pkg_list


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="""
    Prints a list of package names and URLs. Considers one, some, or all project builds in determining
    which packages are relevant to mirror. Specify PROJECT=W DEVICE=X ARCH=Y UBOOT_SYSTEM=Z like other
    build commands to mirror to a single project build's files. Specify other options listed below to
    consider more than one project build.
    """)
    parser.add_argument('-a', '--all', action='store_true', \
                       help='Consider all project/devices when determining what files to keep in sources directory.')
    parser.add_argument('-b', '--builddirs', action='store_true', \
                       help='Filter build list used by --all to only include builds with a present project/device/arch build directory.')
    parser.add_argument('-e', '--export', action='store', nargs='?', \
                       help='Export list of package source files to keep to file.')
    args = parser.parse_args()


    # sanity check
    if args.export:
        export_path = args.export if args.export.startswith('/') else os.path.join(os.getcwd(), args.export)
        if os.path.isfile(export_path):
            print(f'Error: Export file already exists: {export_path}')
            sys.exit(1)


    # get package details to build a source repository mirror
    pkg_list = get_git_packagelist()
    if args.export:
        if not os.path.isfile(export_path):
            with open(export_path, mode='w', encoding='utf-8') as export_file:
                for package in pkg_list:
                    export_file.write(f'{package[0]} {package[1]}\n')
            print(f'Exported list of files to: {export_path}')
    else:
        for package in pkg_list:
            print(f'{package[0]} {package[1]}')
