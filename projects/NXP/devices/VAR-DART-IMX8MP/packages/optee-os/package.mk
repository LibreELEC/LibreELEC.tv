# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# NXP imx-optee-os, same LF tag as imx-mkimage (lf-6.18.20_2.0.0).
# DART-MX8MP: 4 GiB DRAM, TEE at 0x56000000, console UART1 (ttymxc0).

PKG_NAME="optee-os"
PKG_VERSION="37c7fbf84c40eb9e5828532972ffb133b4917390"
PKG_SHA256="93d4465d4158afcd8742b6351c15866bb44e1d17c23a54865df7b9d2cbd0fe7c"
PKG_ARCH="aarch64"
PKG_LICENSE="BSD-2-Clause"
PKG_SITE="https://github.com/nxp-imx/imx-optee-os"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3:host pycryptodome:host dtc:host openssl:host"
PKG_LONGDESC="OP-TEE OS for i.MX8MP. Produces tee.bin for imx-mkimage iMX8M."
PKG_TOOLCHAIN="manual"

# Board is VSM-DT8MP-302, U-Boot reports DRAM: 4 GiB.
# Variscite machine default TEE_CFG_DDR_SIZE. TZDRAM is 0x40000000+0x16000000.
TEE_CFG_DDR_SIZE="0x100000000"
OPTEE_PLATFORM="imx-mx8mpevk"

[ -n "${KERNEL_TOOLCHAIN}" ] && PKG_DEPENDS_TARGET+=" gcc-${KERNEL_TOOLCHAIN}:host"

unpack() {
  mkdir -p ${PKG_BUILD}
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}
}

post_patch() {
  # pem_to_pub_c.py imports cryptography (Rust). Use LE's pycryptodome:host.
  cat >"${PKG_BUILD}/scripts/pem_to_pub_c.py" <<'EOF'
#!/usr/bin/env python3
# SPDX-License-Identifier: BSD-2-Clause

def get_args():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('--prefix', required=True)
    parser.add_argument('--out', required=True)
    parser.add_argument('--key', required=True)
    return parser.parse_args()

def main():
    import array
    from Crypto.PublicKey import RSA

    args = get_args()
    with open(args.key, 'rb') as f:
        key = RSA.import_key(f.read())
        if key.has_private():
            key = key.public_key()

    if key.e > 0xffffffff:
        raise ValueError('Unsupported large public exponent detected.')

    with open(args.out, 'w') as f:
        f.write("#include <stdint.h>\n#include <stddef.h>\n\n")
        f.write("const uint32_t " + args.prefix + "_exponent = " + str(key.e) + ";\n\n")
        f.write("const uint8_t " + args.prefix + "_modulus[] = {\n")
        i = 0
        nbuf = key.n.to_bytes(key.size_in_bits() >> 3, 'big')
        for x in array.array("B", nbuf):
            f.write("0x" + '{0:02x}'.format(x) + ",")
            i = i + 1
            f.write("\n" if i % 8 == 0 else " ")
        f.write("};\n")
        f.write("const size_t " + args.prefix + "_modulus_size = sizeof(" +
                args.prefix + "_modulus);\n")

if __name__ == "__main__":
    main()
EOF
  chmod +x "${PKG_BUILD}/scripts/pem_to_pub_c.py"
}

make_target() {
  unset AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP STRIP RANLIB
  unset CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
  # LE exports ARCH=aarch64. OP-TEE still uses ARCH=arm (64-bit is CFG_ARM64_core).
  unset ARCH

  CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" \
  CROSS_COMPILE64="${TARGET_KERNEL_PREFIX}" \
  make \
    ARCH=arm \
    PLATFORM="${OPTEE_PLATFORM}" \
    CFG_DDR_SIZE="${TEE_CFG_DDR_SIZE}" \
    CFG_UART_BASE=UART1_BASE \
    CFG_BUILD_IN_TREE_TA=n \
    CFG_TEE_CORE_LOG_LEVEL=1 \
    CFG_TEE_TA_LOG_LEVEL=0 \
    COMPILER=gcc \
    PYTHON3="${TOOLCHAIN}/bin/python3"
}

makeinstall_target() {
  local tee
  # ATF jumps to BL32_BASE (0x56000000). tee.bin has a 28-byte OPTE
  # header; executing that hangs at "BL31: Initializing BL32".
  # tee-raw.bin is the image linked at CFG_TZDRAM_START.
  tee="$(find "${PKG_BUILD}/out" -name tee-raw.bin -print -quit)"
  [ -n "${tee}" ] || tee="$(find "${PKG_BUILD}/out" -name tee.bin -print -quit)"
  [ -n "${tee}" ] || { echo "optee-os: tee-raw.bin/tee.bin not produced"; exit 1; }
  mkdir -p ${INSTALL}/usr/share/bootloader
  cp -av "${tee}" ${INSTALL}/usr/share/bootloader/tee.bin
}
