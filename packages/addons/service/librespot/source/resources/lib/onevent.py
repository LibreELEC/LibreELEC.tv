import json
import os
import socket
import sys
import time

HOST = "127.0.0.1"
SOCK_AF = socket.AF_INET
SOCK_TYPE = socket.SOCK_DGRAM


def _get(key):
    return os.environ.get(key, "")


def _get_first(key):
    return os.environ.get(key, "").partition("\n")[0]


def _get_time(key):
    return int(os.environ.get(key, "0")) / 1000


def _on_event():
    event = _get("PLAYER_EVENT")
    dict = {}
    if event in ["paused", "playing", "position_correction", "seeked"]:
        dict["position"] = _get_time("POSITION_MS")
        dict["then"] = time.time()
    elif event == "track_changed":
        dict["art"] = _get_first("COVERS")
        dict["duration"] = round(_get_time("DURATION_MS"))
        dict["title"] = _get("NAME")
        item_type = _get("ITEM_TYPE")
        match item_type:
            case "Track":
                dict["album"] = _get("ALBUM")
                dict["artist"] = _get_first("ARTISTS")
            case "Episode":
                dict["album"] = _get("SHOW_NAME")
    elif event == "stopped":
        pass
    else:
        return
    port = int(sys.argv[1])
    send_event(port, event, dict)


def send_event(port, event="", dict={}):
    data = json.dumps([event, dict]).encode()
    with socket.socket(SOCK_AF, SOCK_TYPE) as sock:
        sock.sendto(data, (HOST, port))


if __name__ == "__main__":
    _on_event()
