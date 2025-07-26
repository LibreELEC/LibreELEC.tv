import xbmc

import service
import service_pulseaudio
import utils


def _get_service():
    while True:
        backend = utils.get_setting("backend")
        match backend:
            case "alsa":
                alsa_device = utils.get_setting("alsa_device")
                service_ = service.Service(backend, alsa_device)
            case _:
                service_ = service_pulseaudio.Service()
        yield from service_.run()


class _Monitor(xbmc.Monitor):
    @utils.logged_method
    def __init__(self):
        super().__init__()
        self._service = _get_service()
        next(self._service)

    @utils.logged_method
    def onSettingsChanged(self):
        next(self._service)


def run():
    _Monitor().waitForAbort()
