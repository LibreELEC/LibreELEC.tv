import json
import socket
import threading

import onevent
import utils

_BUFFER = 1024


class EventHandler:
    @utils.logged_method
    def __init__(self, target):
        self._target = target
        self._socket = socket.socket(onevent.SOCK_AF, onevent.SOCK_TYPE)
        self._socket.settimeout(None)
        self._socket.bind((onevent.HOST, 0))
        self._port = self._socket.getsockname()[1]
        self._receiver = threading.Thread(target=self._handle_events)
        self._receiver.start()

    @utils.logged_method
    def __enter__(self):
        return self

    @utils.logged_method
    def __exit__(self, *_):
        onevent.send_event(self._port)
        self._receiver.join()

    def _handle_events(self):
        utils.log(f"Event handler listening on port {self._port}")
        with self._socket:
            while True:
                data, _ = self._socket.recvfrom(_BUFFER)
                event, dict = json.loads(data)
                if event:
                    try:
                        utils.log(f"Event handler handling {event}{dict}")
                        method = f"on_event_{event}"
                        getattr(self._target, method)(**dict)
                    except Exception as e:
                        utils.log(f"Event handler failed to handle {event}: {e}")
                else:
                    break
        utils.log("Event handler ended")

    def get_onevent(self):
        return f"python {onevent.__file__} {self._port}"
