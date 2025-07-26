import pulseaudio
import service
import utils


class Service(service.Service):
    @utils.logged_method
    def __init__(self):
        self.pulseaudio = pulseaudio.PulseAudio()
        backend = "pulseaudio"
        device = self.pulseaudio.get_device()
        file = self.pulseaudio.get_file()
        super().__init__(backend, device, file)

    @utils.logged_method
    def run(self):
        with self.pulseaudio:
            yield from super().run()

    def on_event_paused(self, **kwargs):
        self.pulseaudio.suspend_sink("0")
        self.player.do_paused(**kwargs)

    def on_event_playing(self, **kwargs):
        self.pulseaudio.suspend_sink("0")
        self.player.do_playing(**kwargs)

    def on_event_position_correction(self, **kwargs):
        self.player.do_seeked(**kwargs)

    def on_event_seeked(self, **kwargs):
        self.player.do_seeked(**kwargs)

    def on_event_stopped(self, **_):
        self.player.do_stopped()
        self.pulseaudio.suspend_sink("1")

    def on_event_track_changed(self, **kwargs):
        self.player.do_track_changed(**kwargs)

    def on_librespot_started(self):
        self.pulseaudio.suspend_sink("1")

    def on_librespot_stopped(self):
        self.pulseaudio.suspend_sink("1")
