import subprocess

import utils


def _run(command):
    stdout = subprocess.run(
        command.split(), stdout=subprocess.PIPE, text=True
    ).stdout.rstrip()
    utils.log(f"{command}: {stdout}")
    return stdout


class PulseAudio:
    @utils.logged_method
    def __init__(self, address="127.0.0.1", device="librespot", port="23432"):
        self._device = device
        self._file = f"rtp://{address}:{port}"
        self._sap_server = subprocess.Popen(
            f"nc -lup 9875 -s {address}".split(),
            stdout=subprocess.DEVNULL,
            stderr=subprocess.STDOUT,
        )
        self._m1 = _run(f"pactl load-module module-null-sink sink_name={device}")
        self.suspend_sink(1)
        self._m2 = _run(
            f"pactl load-module module-rtp-send destination_ip={address} inhibit_auto_suspend=always port={port} source={device}.monitor"
        )

    @utils.logged_method
    def __enter__(self):
        return self

    @utils.logged_method
    def __exit__(self, *args):
        self.suspend_sink("1")
        for m in [self._m2, self._m1]:
            if m:
                _run(f"pactl unload-module {m}")
        self._sap_server.terminate()

    def get_device(self):
        return self._device

    def get_file(self):
        return self._file

    def suspend_sink(self, bit):
        _run(f"pactl suspend-sink {bit}")
