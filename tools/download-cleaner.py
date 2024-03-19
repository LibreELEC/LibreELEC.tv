#! /usr/bin/env python3

#SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Ian Leonard (antonlacon@gmail.com)

'''
This prunes the sources download directory to remove source tarballs
no longer in use by the current git tree. It does so by generating the
build plan for every selected project/device/arch/uboot_system combination
and then running pkginfo on each of the specified packages to be built to
obtain the source tarball it would download.

By default, the script only lists files that would be removed. Add --delete
to also remove them.

The script may be invoked three ways:

./download-cleaner.py --all

This considers every project/device/arch/uboot_system in builds_all.

./download-cleaner.py --builddirs

This filters --all's build list to only ones with a build directory.

PROJECT=W DEVICE=X ARCH=Y UBOOT_SYSTEM=Z ./download-cleaner.py

This runs against the project/device/arch specificed on the CLI.

For working with multiple git branches (different versions), there are
additional options:

--export filename to write a list of packages and their source tarballs to
file. --export may not be invoked with --delete.

./downloadcleaner.py --builddirs --export file1

--import to load one or more files created by --export to include in the
decision making of what to keep and what to delete.

./downloadcleaner.py --builddirs --import file1
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


def parse_builder_options(file):
    '''Read builder settings from file.'''
    with open(file, mode='r', encoding='utf-8') as data:
        content = data.read()
    for line in content.splitlines():
        line = line.strip()
        if line[0:11] == 'SOURCES_DIR':
            return line.split('=')[1].strip('\"')
    return None


# build list of packages with desired versions to keep
def get_git_packagelist():
    '''Create list of packages and their downloaded filenames for every setup in builds'''
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

    # process each file given to --import, adding new content to pkg_list
    if args.input:
        for input_file in args.input:
            input_path = os.path.join(os.getcwd(), input_file)
            if os.path.isfile(input_path):
                with open(input_path, mode='r') as data:
                    content = data.read()
                for line in content.splitlines():
                    item, pkg_filename = line.split(' ')
                    if [item, pkg_filename] not in pkg_list:
                        pkg_list.append([item, pkg_filename])
            else:
                print(f'Error: File not found: {input_path}')
                sys.exit(1)

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
                # get package filename
                pkg_filename = execute(f'{cmd_build} tools/pkginfo --strip {item}').strip()
                for line in pkg_filename.splitlines():
                    if line.startswith('PKG_URL'):
                        pkg_filename = line.split('=')[-1].strip('"').split('/')[-1]
                        break
                # add package and filename to master list if not present
                if pkg_filename and [item, pkg_filename] not in pkg_list:
                    pkg_list.append([item, pkg_filename])
    return pkg_list


def generate_delete_list():
    '''Compare files in source dir against desired files for packages in git tree'''
    files_to_delete = ''
    # populate package list for comparison
    package_versions_in_tree = get_git_packagelist()
    # compare packages in sources directory against what is wanted from git tree
    if os.path.isdir(SOURCES_DIR) and package_versions_in_tree:
        # each directory is a package
        for package in os.listdir(SOURCES_DIR):
            pkg_list = ''
            if os.path.isdir(f'{SOURCES_DIR}/{package}'):
                for file in os.listdir(f'{SOURCES_DIR}/{package}'):
                    # skip auxilliary files
                    if file.endswith(('.url', '.sha256')):
                        continue
                    # test for file in use by git tree
                    for tree_entry in package_versions_in_tree:
                        if tree_entry[0] not in pkg_list:
                            pkg_list = f'{pkg_list} {tree_entry[0]}'
                        if package == tree_entry[0] and file != tree_entry[1]:
                            file_path = f'{SOURCES_DIR}/{package}/{file}'
                            if file_path not in files_to_delete:
                                files_to_delete = f'{files_to_delete}\n{file_path}' if files_to_delete else file_path
                            if os.path.isfile(f'{file_path}.url') and f'{file_path}.url' not in files_to_delete:
                                files_to_delete = f'{files_to_delete}\n{file_path}.url'
                            if os.path.isfile(f'{file_path}.sha256') and f'{file_path}.sha256' not in files_to_delete:
                                files_to_delete = f'{files_to_delete}\n{file_path}.sha256'
                            # end loop after package's source dir is evaluated
                            break
                # downloaded packages that are no longer in tree
                if package not in pkg_list:
                    file_path = f'{SOURCES_DIR}/{package}'
                    if file_path not in files_to_delete:
                        files_to_delete = f'{files_to_delete}\n{file_path}' if files_to_delete else file_path
    return files_to_delete


def prune_source_dir():
    purge_filepaths = generate_delete_list()
    if purge_filepaths:
        for file in purge_filepaths.splitlines():
            print(file)
            if args.delete:
                if os.path.isdir(file):
                    shutil.rmtree(file)
                else:
                    os.remove(file)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="""
    Prints, and optionally deletes, a list of directories and files from the buildsystem's
    sources directory. Considers one, some, or all project builds in determining stale downloads.
    Specify PROJECT=W DEVICE=X ARCH=Y UBOOT_SYSTEM=Z like other build commands to prune to a single
    project build's files. Specify other options listed below to consider more than one project build.
    """)
    parser.add_argument('-a', '--all', action='store_true', \
                       help='Consider all project/devices when determining what files to keep in sources directory.')
    parser.add_argument('-b', '--builddirs', action='store_true', \
                       help='Filter build list used by --all to only include builds with a present project/device/arch build directory.')
    result_group = parser.add_mutually_exclusive_group()
    result_group.add_argument('-d', '--delete', action='store_true', \
                       help='Delete files in addition to listing them.')
    result_group.add_argument('-e', '--export', action='store', nargs='?', \
                       help='Export list of package source files to keep to file.')
    parser.add_argument('-i', '--import', action='store', nargs='*', dest='input', \
                       help='Import list of package source files from one or more files to keep')
    args = parser.parse_args()


    # sources directory
    SOURCES_DIR = None
    # in tree git controlled options that may contain SOURCES_DIR
    if os.path.isfile(f'{os.getcwd()}/.libreelec/options'):
        SOURCES_DIR = parse_builder_options(f'{os.getcwd()}/.libreelec/options')
    # global options in home may contain SOURCES_DIR
    if os.path.isfile(f'{os.getenv("HOME")}/.libreelec/options'):
        SOURCES_DIR = parse_builder_options(f'{os.getenv("HOME")}/.libreelec/options')
    # default SOURCES
    if not SOURCES_DIR:
        SOURCES_DIR = f'{os.getcwd()}/sources'
    # expands ~ to home dir
    SOURCES_DIR = os.path.expanduser(SOURCES_DIR)
    # expands $HOME to home dir
    SOURCES_DIR = os.path.expandvars(SOURCES_DIR)

    if not os.path.isdir(SOURCES_DIR):
        print(f'Error: Abort: Unable to find directory: {SOURCES_DIR}')
        sys.exit(1)


    if args.export:
        export_path = os.path.join(os.getcwd(), args.export)
        if not os.path.isfile(export_path):
            pkg_list = get_git_packagelist()
            with open(export_path, mode='w') as export_file:
                for package in pkg_list:
                    export_file.write(f'{package[0]} {package[1]}\n')
            print(f'Exported list of files to keep to: {export_path}')
        else:
            print(f'Error: Export file already exists: {export_path}')
            sys.exit(1)
    else:
        prune_source_dir()
