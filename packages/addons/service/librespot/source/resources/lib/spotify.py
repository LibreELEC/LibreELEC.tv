import PIL.Image
import os
import tempfile
import urllib.request

_DIRECTORY_NAME = "librespot.coverart"
_DIRECTORY_PATH = os.path.join(tempfile.gettempdir(), _DIRECTORY_NAME)
_MAX_COVERARTS = 10


def get_fanart(url):
    name = os.path.basename(url)
    target = os.path.join(_DIRECTORY_PATH, f"{name}")
    if not os.path.exists(target):
        if not os.path.exists(_DIRECTORY_PATH):
            os.makedirs(_DIRECTORY_PATH)
        paths = [
            os.path.join(_DIRECTORY_PATH, file) for file in os.listdir(_DIRECTORY_PATH)
        ]
        paths = [path for path in paths if os.path.isfile(path)]
        paths.sort(key=os.path.getmtime)
        for path in paths[:-_MAX_COVERARTS]:
            os.remove(path)
        source = os.path.join(_DIRECTORY_PATH, f"{name}.tmp")
        urllib.request.urlretrieve(url, source)
        image = PIL.Image.open(source)
        width, height = image.size
        new_width = int(height * 16 / 9)
        delta_w = new_width - width
        new_image = PIL.Image.new("RGB", (new_width, height), (0, 0, 0))
        new_image.paste(image, (delta_w // 2, 0))
        new_image.save(target, "JPEG", optimize=True)
        os.remove(source)
    return target
