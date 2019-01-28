# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)

import os
import subprocess
import sys
import threading
import time
import xbmc
import xbmcaddon
import xbmcgui

sys.path.append('/usr/share/kodi/addons/service.libreelec.settings')
import oe

__author__      = 'lrusak'
__addon__       = xbmcaddon.Addon()
__path__        = __addon__.getAddonInfo('path')

sys.path.append(__path__ + '/lib')
import dockermon

# docker events for api 1.23 (docker version 1.11.x)
# https://docs.docker.com/engine/reference/api/docker_remote_api_v1.23/#monitor-docker-s-events

docker_events = {
                  'container': {
                                 'string': 30010,
                                 'event': {
                                            'attach':       {
                                                              'string': 30011,
                                                              'enabled': '',
                                                            },
                                            'commit':       {
                                                              'string': 30012,
                                                              'enabled': '',
                                                            },
                                            'copy':         {
                                                              'string': 30013,
                                                              'enabled': '',
                                                            },
                                            'create':       {
                                                              'string': 30014,
                                                              'enabled': '',
                                                            },
                                            'destroy':      {
                                                              'string': 30015,
                                                              'enabled': '',
                                                            },
                                            'die':          {
                                                              'string': 30016,
                                                              'enabled': '',
                                                            },
                                            'exec_create':  {
                                                              'string': 30017,
                                                              'enabled': '',
                                                            },
                                            'exec_start':   {
                                                              'string': 30018,
                                                              'enabled': '',
                                                            },
                                            'export':       {
                                                              'string': 30019,
                                                              'enabled': '',
                                                            },
                                            'kill':         {
                                                              'string': 30020,
                                                              'enabled': True,
                                                            },
                                            'oom':          {
                                                              'string': 30021,
                                                              'enabled': True,
                                                            },
                                            'pause':        {
                                                              'string': 30022,
                                                              'enabled': '',
                                                            },
                                            'rename':       {
                                                              'string': 30023,
                                                              'enabled': '',
                                                            },
                                            'resize':       {
                                                              'string': 30024,
                                                              'enabled': '',
                                                            },
                                            'restart':      {
                                                              'string': 30025,
                                                              'enabled': '',
                                                            },
                                            'start':        {
                                                              'string': 30026,
                                                              'enabled': True,
                                                            },
                                            'stop':         {
                                                              'string': 30027,
                                                              'enabled': True,
                                                            },
                                            'top':          {
                                                              'string': 30028,
                                                              'enabled': '',
                                                            },
                                            'unpause':      {
                                                              'string': 30029,
                                                              'enabled': '',
                                                            },
                                            'update':       {
                                                              'string': 30030,
                                                              'enabled': '',
                                                            },
                                          },
                               },
                  'image':     {
                                 'string': 30031,
                                 'event': {
                                            'delete':       {
                                                              'string': 30032,
                                                              'enabled': '',
                                                            },
                                            'import':       {
                                                              'string': 30033,
                                                              'enabled': '',
                                                            },
                                            'pull':         {
                                                              'string': 30034,
                                                              'enabled': True,
                                                            },
                                            'push':         {
                                                              'string': 30035,
                                                              'enabled': '',
                                                            },
                                            'tag':          {
                                                              'string': 30036,
                                                              'enabled': '',
                                                            },
                                            'untag':        {
                                                              'string': 30037,
                                                              'enabled': '',
                                                            },
                                          },
                               },
                  'volume':    {
                                 'string': 30038,
                                 'event': {
                                            'create':       {
                                                              'string': 30039,
                                                              'enabled': '',
                                                            },
                                            'mount':        {
                                                              'string': 30040,
                                                              'enabled': '',
                                                            },
                                            'unmount':      {
                                                              'string': 30041,
                                                              'enabled': '',
                                                            },
                                            'destroy':      {
                                                              'string': 30042,
                                                              'enabled': '',
                                                            },
                                          },
                               },
                  'network':   {
                                 'string': 30043,
                                 'event': {
                                            'create':       {
                                                              'string': 30044,
                                                              'enabled': '',
                                                            },
                                            'connect':      {
                                                              'string': 30045,
                                                              'enabled': '',
                                                            },
                                            'disconnect':   {
                                                              'string': 30046,
                                                              'enabled': '',
                                                            },
                                            'destroy':      {
                                                              'string': 30047,
                                                              'enabled': '',
                                                            },
                                          },
                                },
                }

def print_notification(json_data):
    event_string = docker_events[json_data['Type']]['event'][json_data['Action']]['string']
    if __addon__.getSetting('notifications') is '0': # default
        if docker_events[json_data['Type']]['event'][json_data['Action']]['enabled']:
            try:
                message = unicode(' '.join([__addon__.getLocalizedString(30007),
                                            json_data['Actor']['Attributes']['name'],
                                            '|',
                                            __addon__.getLocalizedString(30009),
                                            __addon__.getLocalizedString(event_string)]))
            except KeyError as e:
                message = unicode(' '.join([__addon__.getLocalizedString(30008),
                                            json_data['Type'],
                                            '|',
                                            __addon__.getLocalizedString(30009),
                                            __addon__.getLocalizedString(event_string)]))

    elif __addon__.getSetting('notifications') is '1': # all
        try:
            message = unicode(' '.join([__addon__.getLocalizedString(30007),
                                        json_data['Actor']['Attributes']['name'],
                                        '|',
                                        __addon__.getLocalizedString(30009),
                                        __addon__.getLocalizedString(event_string)]))
        except KeyError as e:
            message = unicode(' '.join([__addon__.getLocalizedString(30008),
                                        json_data['Type'],
                                        '|',
                                        __addon__.getLocalizedString(30009),
                                        __addon__.getLocalizedString(event_string)]))

    elif __addon__.getSetting('notifications') is '2': # none
        pass

    elif __addon__.getSetting('notifications') is '3': # custom
        if __addon__.getSetting(json_data['Action']) == 'true':
            try:
                message = unicode(' '.join([__addon__.getLocalizedString(30007),
                                            json_data['Actor']['Attributes']['name'],
                                            '|',
                                            __addon__.getLocalizedString(30009),
                                            __addon__.getLocalizedString(event_string)]))
            except KeyError as e:
                message = unicode(' '.join([__addon__.getLocalizedString(30008),
                                            json_data['Type'],
                                            '|',
                                            __addon__.getLocalizedString(30009),
                                            __addon__.getLocalizedString(event_string)]))

    dialog = xbmcgui.Dialog()
    try:
        if message is not '':
            length = int(__addon__.getSetting('notification_length')) * 1000
            dialog.notification('Docker', message, '/storage/.kodi/addons/service.system.docker/resources/icon.png', length)
            xbmc.log('## service.system.docker ## ' + unicode(message))
    except NameError as e:
        pass

class dockermonThread(threading.Thread):

    def __init__(self):
        threading.Thread.__init__(self)
        self._is_running = True

    def run(self):
        while self._is_running:
            dockermon.watch(print_notification)

    def stop(self):
        self._is_running = False

class Main(object):

    def __init__(self, *args, **kwargs):

        #############################
        # Temp cleanup for old method

        restart_docker = False

        if os.path.islink('/storage/.config/system.d/service.system.docker.socket'):
            os.remove('/storage/.config/system.d/service.system.docker.socket')
        if os.path.islink('/storage/.config/system.d/docker.socket'):
            os.remove('/storage/.config/system.d/docker.socket')

        if os.path.islink('/storage/.config/system.d/service.system.docker.service'):
            if 'systemd' in os.readlink('/storage/.config/system.d/service.system.docker.service'):
                os.remove('/storage/.config/system.d/service.system.docker.service')
                restart_docker = True

        if os.path.islink('/storage/.config/system.d/docker.service'):
            if 'systemd' in os.readlink('/storage/.config/system.d/docker.service'):
                os.remove('/storage/.config/system.d/docker.service')
                restart_docker = True

        if os.path.islink('/storage/.config/system.d/multi-user.target.wants/service.system.docker.service'):
            if 'systemd' in os.readlink('/storage/.config/system.d/multi-user.target.wants/service.system.docker.service'):
                os.remove('/storage/.config/system.d/multi-user.target.wants/service.system.docker.service')
                restart_docker = True

        if restart_docker:
            oe.execute('systemctl enable  /storage/.kodi/addons/service.system.docker/system.d/service.system.docker.service')
            oe.execute('systemctl restart /storage/.kodi/addons/service.system.docker/system.d/service.system.docker.service')

        # end temp cleanup
        #############################

        monitor = DockerMonitor(self)

        while not monitor.abortRequested():
            if monitor.waitForAbort():
                # we don't want to stop or disable docker while it's installed
                pass

class DockerMonitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)

    def onSettingsChanged(self):
        pass

if ( __name__ == "__main__" ):
    dockermonThread().start()
    Main()

    del DockerMonitor
    dockermonThread().stop()
