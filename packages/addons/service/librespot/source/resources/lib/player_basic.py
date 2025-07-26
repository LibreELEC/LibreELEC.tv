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

    def do_paused(self, **kwargs):
        self.do_playing(**kwargs)

    @utils.logged_method
    def do_playing(self, **_):
        if not self.is_playing_file():
            self.play(self.file, self._list_item)

    @utils.logged_method
    def do_track_changed(self, album="", art="", artist="", title="", **_):
        fanart = spotify.get_fanart(art)
        self._list_item.setArt({"fanart": fanart, "thumb": art})
        self._info_tag_music.setAlbum(album)
        self._info_tag_music.setArtist(artist)
        self._info_tag_music.setTitle(title)
        if self.is_playing_file():
            self.updateInfoTag(self._list_item)
