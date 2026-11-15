/*
 * Walk /dev/video* the same way FFmpeg's v4l2_m2m decoders do:
 * QUERYCAP, require M2M, ENUM_FMT on OUTPUT (coded) and CAPTURE (raw).
 *
 * Built with the LibreELEC aarch64 toolchain. No ffmpeg CLI is shipped
 * (--disable-programs); Kodi links libavcodec with --enable-v4l2_m2m.
 */

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/videodev2.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <unistd.h>

static const char *fourcc(unsigned int f)
{
  static char s[5];
  s[0] = f & 0xff;
  s[1] = (f >> 8) & 0xff;
  s[2] = (f >> 16) & 0xff;
  s[3] = (f >> 24) & 0xff;
  s[4] = 0;
  return s;
}

static int is_coded(unsigned int f)
{
  switch (f) {
  case V4L2_PIX_FMT_H264:
  case V4L2_PIX_FMT_H264_NO_SC:
  case V4L2_PIX_FMT_H264_MVC:
  case V4L2_PIX_FMT_HEVC:
  case V4L2_PIX_FMT_MPEG2:
  case V4L2_PIX_FMT_MPEG4:
  case V4L2_PIX_FMT_VP8:
  case V4L2_PIX_FMT_VP9:
    return 1;
  default:
    return 0;
  }
}

static int enum_fmt(int fd, unsigned int type, const char *label)
{
  struct v4l2_fmtdesc fmt;
  int i, n = 0, coded = 0;

  printf("  %s:\n", label);
  for (i = 0; ; i++) {
    memset(&fmt, 0, sizeof(fmt));
    fmt.type = type;
    fmt.index = i;
    if (ioctl(fd, VIDIOC_ENUM_FMT, &fmt) < 0)
      break;
    n++;
    if (is_coded(fmt.pixelformat))
      coded++;
    printf("    [%u] %s  %s%s\n", fmt.index, fourcc(fmt.pixelformat),
           fmt.description,
           (fmt.flags & V4L2_FMT_FLAG_COMPRESSED) ? " (compressed)" : "");
  }
  if (!n)
    printf("    (none, errno=%d %s)\n", errno, strerror(errno));
  else if (type == V4L2_BUF_TYPE_VIDEO_OUTPUT ||
           type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
    printf("    coded formats FFmpeg can bind: %d\n", coded);
  return coded;
}

static int probe(const char *path)
{
  int fd, coded = 0;
  struct v4l2_capability cap;
  unsigned int caps;

  fd = open(path, O_RDWR | O_NONBLOCK);
  if (fd < 0) {
    printf("%s: open failed: %s\n", path, strerror(errno));
    return 0;
  }

  memset(&cap, 0, sizeof(cap));
  if (ioctl(fd, VIDIOC_QUERYCAP, &cap) < 0) {
    printf("%s: QUERYCAP failed: %s\n", path, strerror(errno));
    close(fd);
    return 0;
  }

  caps = cap.device_caps ? cap.device_caps : cap.capabilities;
  printf("%s\n", path);
  printf("  driver=%s card='%s' bus=%s\n", cap.driver, cap.card, cap.bus_info);
  printf("  caps=0x%08x%s%s%s%s\n", caps,
         (caps & V4L2_CAP_VIDEO_M2M) ? " M2M" : "",
         (caps & V4L2_CAP_VIDEO_M2M_MPLANE) ? " M2M_MPLANE" : "",
         (caps & V4L2_CAP_VIDEO_CAPTURE) ? " CAPTURE" : "",
         (caps & V4L2_CAP_STREAMING) ? " STREAMING" : "");

  if (!(caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))) {
    printf("  not a mem2mem node (FFmpeg v4l2_m2m skips this)\n");
    close(fd);
    return 0;
  }

  if (caps & V4L2_CAP_VIDEO_M2M_MPLANE) {
    coded = enum_fmt(fd, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
                     "OUTPUT_MPLANE (coded in)");
    enum_fmt(fd, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE, "CAPTURE_MPLANE (raw out)");
  } else {
    coded = enum_fmt(fd, V4L2_BUF_TYPE_VIDEO_OUTPUT, "OUTPUT (coded in)");
    enum_fmt(fd, V4L2_BUF_TYPE_VIDEO_CAPTURE, "CAPTURE (raw out)");
  }

  close(fd);
  return coded > 0;
}

int main(void)
{
  DIR *d;
  struct dirent *e;
  char path[64];
  int m2m = 0, nodes = 0;

  printf("FFmpeg on this image: --enable-v4l2_m2m --disable-v4l2-request --disable-programs\n");
  printf("Kodi uses libavcodec h264_v4l2m2m / hevc_v4l2m2m when a node advertises those fourccs.\n\n");

  d = opendir("/dev");
  if (!d) {
    perror("/dev");
    return 1;
  }
  while ((e = readdir(d))) {
    if (strncmp(e->d_name, "video", 5) != 0)
      continue;
    if (e->d_name[5] < '0' || e->d_name[5] > '9')
      continue;
    snprintf(path, sizeof(path), "/dev/%s", e->d_name);
    nodes++;
    m2m += probe(path);
    printf("\n");
  }
  closedir(d);

  printf("nodes=%d m2m=%d\n", nodes, m2m);
  if (!m2m)
    printf("FAIL: no usable V4L2 M2M decoder. FFmpeg stays on software h264.\n");
  return m2m ? 0 : 2;
}
