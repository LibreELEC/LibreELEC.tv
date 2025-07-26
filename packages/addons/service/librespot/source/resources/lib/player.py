import xbmc

import utils


class Player(xbmc.Player):
    @utils.logged_method
    def __init__(self, target, file, librespot):
        self._target = target
        self.file = file
        self._librespot = librespot
        self._dnd_kodi = utils.get_setting("dnd_kodi") == "true"
        self._was_playing_file = False
        if not self._dnd_kodi or not self.isPlaying():
            self._librespot.start()

    def _on_playback_ended(self):
        was_playing_file = self._was_playing_file
        self._was_playing_file = False
        if was_playing_file:
            self._librespot.restart()
        else:
            self._librespot.start()

    def is_playing_file(self):
        return self.isPlaying() and self.getPlayingFile() == self.file

    @utils.logged_method
    def onAVStarted(self):
        if self.is_playing_file():
            self._was_playing_file = True
            self.on_playback_started()
        else:
            self._was_playing_file = False
            if self._dnd_kodi:
                self._librespot.stop()
            else:
                self._librespot.start()

    @utils.logged_method
    def onPlayBackEnded(self):
        self._on_playback_ended()

    @utils.logged_method
    def onPlayBackError(self):
        self._on_playback_ended()

    @utils.logged_method
    def onPlayBackStopped(self):
        self._on_playback_ended()

    def on_playback_started(self):
        pass

    def do_paused(self, **_):
        pass

    def do_playing(self, **_):
        pass

    def do_position_correction(self, **_):
        pass

    def do_seeked(self, **_):
        pass

    @utils.logged_method
    def do_stopped(self, **_):
        if self._was_playing_file:
            self._was_playing_file = False
            self.stop()

    @utils.logged_method
    def do_track_changed(self, album="", art="", artist="", title="", **_):
        if not self.isPlaying():
            utils.notification(title, artist if artist else album, art)

    def on_librespot_started(self):
        pass

    def on_librespot_stopped(self):
        pass
