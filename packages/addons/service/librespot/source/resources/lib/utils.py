import os
import xbmc
import xbmcaddon
import xbmcgui
import xbmcvfs

_ADDON_HOME = xbmcvfs.translatePath(xbmcaddon.Addon().getAddonInfo("profile"))
_ADDON_ICON = xbmcaddon.Addon().getAddonInfo("icon")
_ADDON_NAME = xbmcaddon.Addon().getAddonInfo("name")
_ADDON_PATH = xbmcaddon.Addon().getAddonInfo("path")
_DIALOG = xbmcgui.Dialog()
_SETTINGS = {
    "alsa_device": "hw:2,0",
    "backend": "pulseaudio",
    "dnd_kodi": "false",
    "name": "Librespot{}",
    "player": "default",
}

os.environ["PATH"] += os.pathsep + os.path.join(_ADDON_PATH, "bin")
os.makedirs(_ADDON_HOME, exist_ok=True)
os.chdir(_ADDON_HOME)


def get_setting(key):
    setting = xbmcaddon.Addon().getSetting(key)
    return setting if setting else _SETTINGS[key]


def log(message, notify=False):
    xbmc.log(f"{_ADDON_NAME}: {message}", xbmc.LOGINFO)
    if notify:
        notification(message)


def logged_method(method):
    def logger(*args, **kwargs):
        log(f"{method.__module__}.{method.__qualname__}")
        return method(*args, **kwargs)

    return logger


def notification(
    message="", heading=_ADDON_NAME, icon=_ADDON_ICON, sound=False, time=5000
):
    _DIALOG.notification(heading, message, icon, time, sound)
