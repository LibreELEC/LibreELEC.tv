import event_handler
import librespot
import utils


class Service:
    @utils.logged_method
    def __init__(self, backend, device, file=""):
        self.backend = backend
        self.device = device
        self.file = file

    @utils.logged_method
    def run(self):
        if self.file:
            player = utils.get_setting("player")
            module_player = f"player_{player}"
        else:
            module_player = "player"

        with event_handler.EventHandler(self) as self.event_handler:
            with librespot.Librespot(self, self.backend, self.device) as self.librespot:
                self.player = __import__(module_player).Player(self, self.file, self.librespot)
                try:
                    yield
                finally:
                    del self.player

    def on_event_paused(self, **_):
        pass

    def on_event_playing(self, **_):
        pass

    def on_event_position_correction(self, **_):
        pass

    def on_event_seeked(self, **_):
        pass

    def on_event_stopped(self, **kwargs):
        self.player.do_stopped(**kwargs)

    def on_event_track_changed(self, **kwargs):
        self.player.do_track_changed(**kwargs)

    def on_librespot_started(self):
        pass

    def on_librespot_stopped(self):
        pass
