# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import json
import subprocess
import threading
import xbmc
import xbmcvfs
import xbmcaddon

__addon__ = xbmcaddon.Addon()
__addonid__ = __addon__.getAddonInfo('id')
__addonpath__ = xbmcvfs.translatePath(xbmcaddon.Addon().getAddonInfo('path'))

class KodiFunctions(object):

  def __init__(self):

    self.getjson = {
                      "jsonrpc": "2.0",
                      "method": "Settings.GetSettingValue",
                      "params": {
                                  "setting": "audiooutput.audiodevice",
                                },
                      "id": 1,
                   }

    self.setjson = {
                      "jsonrpc": "2.0",
                      "method": "Settings.SetSettingValue",
                      "params": {
                                  "setting": "audiooutput.audiodevice",
                                  "value": "",
                                },
                      "id": 1,
                   }

    if __addon__.getSetting('audiodevice') == '':
      self.audiodevice = json.loads(xbmc.executeJSONRPC(json.dumps(self.getjson)))['result']['value']
      __addon__.setSetting('audiodevice', self.audiodevice)
    else:
      self.audiodevice = __addon__.getSetting('audiodevice')
    self.pulsedevice = 'PULSE:Default|Bluetooth Audio (PULSEAUDIO)'

    xbmc.log('%s: setting default audio device "%s" on start' % (__addonid__, self.audiodevice), xbmc.LOGINFO)
    self.select_default()

  def select_default(self):

    self.setjson['params']['value'] = self.audiodevice
    xbmc.executeJSONRPC(json.dumps(self.setjson))

  def select_pulse(self):

    self.setjson['params']['value'] = self.pulsedevice
    xbmc.executeJSONRPC(json.dumps(self.setjson))

class BluetoothAudioClient(object):

  def __init__(self):

    xbmc.log('%s: starting add-on' % __addonid__, xbmc.LOGINFO)

    self.kodi = KodiFunctions()
    self.path = __addonpath__ + 'bin/dbusservice.py'

    self.service = subprocess.Popen([self.path], stdout=subprocess.PIPE)

    self._thread = threading.Thread(target=self.loop)
    self._thread.start()


  def loop(self):

    while True:
      line = self.service.stdout.readline()
      if line == b'':
        break
      if line == b'bluetooth\n':
        xbmc.log('%s: switching to bluetooth audio device' % __addonid__, xbmc.LOGINFO)
        self.kodi.select_pulse()
        continue
      if line == b'default\n':
        xbmc.log('%s: switching to default audio device' % __addonid__, xbmc.LOGINFO)
        self.kodi.select_default()
        continue
      xbmc.log('%s: unexpected input: %s' % (__addonid__, line), xbmc.LOGERROR)


  def quit(self):

    xbmc.log('%s: stopping add-on' % __addonid__, xbmc.LOGINFO)

    self.service.terminate()
    self._thread.join()
    del self.service
    self.kodi.select_default()


class BluetoothMonitor(xbmc.Monitor):

  def __init__(self, *args, **kwargs):

    xbmc.Monitor.__init__(self)

if (__name__ == "__main__"):
  monitor = BluetoothMonitor()
  client = BluetoothAudioClient()

  monitor.waitForAbort()

  client.quit()

  del BluetoothAudioClient
  del BluetoothMonitor
