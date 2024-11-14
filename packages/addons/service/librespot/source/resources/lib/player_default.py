import time
import xbmcgui

import player
import spotify
import utils


class Player(player.Player):
    @utils.logged_method
    def __init__(self, target, file, librespot):
        super().__init__(target, file, librespot)
        self._list_item = xbmcgui.ListItem(path=self.file)
        self._list_item.setProperties(
            {
                "inputstream": "inputstream.ffmpeg",
            }
        )
        self._info_tag_music = self._list_item.getMusicInfoTag()
        self._is_paused = False

    def _do_playing(self, paused, position=0.0, then=0.0, **_):
        self._is_paused = paused
        if self.is_playing_file():
            self.do_seeked(position, then)
        else:
            self._position = position
            self._then = then
            self.play(self.file, self._list_item)

    @utils.logged_method
    def do_paused(self, **kwargs):
        self._do_playing(True, **kwargs)

    @utils.logged_method
    def do_playing(self, **kwargs):
        self._do_playing(False, **kwargs)

    @utils.logged_method
    def do_seeked(self, position=0.0, then=0.0, **_):
        if self._is_paused:
            self.seekTime(position)
            self.pause()
        else:
            self.seekTime(position - then + time.time())

    @utils.logged_method
    def do_track_changed(self, album="", art="", artist="", duration=0.0, title="", **_):
        fanart = spotify.get_fanart(art)
        self._list_item.setArt({"fanart": fanart, "thumb": art})
        self._info_tag_music.setAlbum(album)
        self._info_tag_music.setArtist(artist)
        self._info_tag_music.setDuration(duration)
        self._info_tag_music.setTitle(title)
        if self.is_playing_file():
            self.updateInfoTag(self._list_item)

    @utils.logged_method
    def on_playback_started(self):
        self.do_seeked(self._position, self._then)
