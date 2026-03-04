# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import os
from shlex import quote
import xbmc
import xbmcvfs
import xbmcaddon


class MyMonitor(xbmc.Monitor):
    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)
    
    def onSettingsChanged(self):
        writeconfig()

            
# addon
__addon__ = xbmcaddon.Addon(id='service.net-snmp')
__addonpath__ = xbmcvfs.translatePath(__addon__.getAddonInfo('path'))
__addonhome__ = xbmcvfs.translatePath(__addon__.getAddonInfo('profile'))
if not xbmcvfs.exists(xbmcvfs.translatePath(__addonhome__ + 'share/snmp/')):
    xbmcvfs.mkdirs(xbmcvfs.translatePath(__addonhome__ + 'share/snmp/'))
config = xbmcvfs.translatePath(__addonhome__ + 'share/snmp/snmpd.conf')
persistent = xbmcvfs.translatePath(__addonhome__ + 'snmpd.conf')


def writeconfig():
    os.system("systemctl stop service.net-snmp.service")
    community = __addon__.getSetting("COMMUNITY")
    location = __addon__.getSetting("LOCATION")
    contact = __addon__.getSetting("CONTACT")
    snmpversion = __addon__.getSetting("SNMPVERSION")
    snmpwrite = __addon__.getSetting("SNMPWRITE")
    cputemp = __addon__.getSetting("CPUTEMP")
    gputemp = __addon__.getSetting("GPUTEMP")

    if xbmcvfs.exists(persistent):
        xbmcvfs.delete(persistent)

    file = xbmcvfs.File(config, 'w')
    file.write('view allview included .1 80\n')
    writeview = 'allview' if snmpwrite == 'true' else 'none'
    file.write(f'syslocation {location}\n')
    file.write(f'syscontact {contact}\n')
    file.write('dontLogTCPWrappersConnects yes\n')

    if cputemp == "true":
        file.write('extend cputemp "/usr/bin/cputemp"\n')

    if gputemp == "true":
        file.write('extend gputemp "/usr/bin/gputemp"\n')

    if snmpversion != "v3":
        file.write(f'com2sec local default {community}\n')
        file.write(f'group localgroup {snmpversion} local\n')
        file.write(f'access localgroup "" any noauth exact allview {writeview} none\n')
        file.close()

    if snmpversion == "v3":
        snmppassword = __addon__.getSetting("SNMPPASSWORD")
        snmpuser = __addon__.getSetting("SNMPUSER")
        snmpauthproto = __addon__.getSetting("SNMPAUTHPROTO")
        snmpprivproto = __addon__.getSetting("SNMPPRIVPROTO")
        snmppriv = __addon__.getSetting("SNMPPRIV")
        accesslevel = "priv" if snmppriv == "true" else "auth"
        file.write('includeFile ../../snmpd.conf\n')
        file.write(f'access v3group "" any {accesslevel} exact allview {writeview} none\n')
        file.write(f'group v3group usm {snmpuser}\n')

        # net-snmp-config modifies snmpd.conf, so we need to stop writing here
        file.close()

        os.environ["PATH"] += os.pathsep + os.path.join(__addonpath__, "bin")
        if snmpwrite == "true":
            os.system(f"net-snmp-config --create-snmpv3-user -a {quote(snmpauthproto)} -A {quote(snmppassword)} -x {quote(snmpprivproto)} -X {quote(snmppassword)} {quote(snmpuser)}")
        else:
            os.system(f"net-snmp-config --create-snmpv3-user -ro -a {quote(snmpauthproto)} -A {quote(snmppassword)} -x {quote(snmpprivproto)} -X {quote(snmppassword)} {quote(snmpuser)}")

    os.system("systemctl start service.net-snmp.service")


if not xbmcvfs.exists(config):
    writeconfig()

monitor = MyMonitor()
while not monitor.abortRequested():
    if monitor.waitForAbort():
        break

