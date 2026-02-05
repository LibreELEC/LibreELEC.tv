# CLAUDE.md - AI Assistant Guide for LibreELEC Build System

This document provides comprehensive guidance for AI assistants working with the LibreELEC build system codebase.

## Project Overview

LibreELEC is a "Just enough OS" Linux distribution for the Kodi media center. The build system creates minimal, optimized Linux images for various hardware platforms including x86_64, ARM, and ARM64 devices.

### Key Characteristics
- **License**: GPLv2
- **Primary Output**: Bootable images (.img.gz) with Kodi media center
- **Supported Architectures**: x86_64, arm, aarch64
- **Build System**: Custom bash-based with multi-threaded support
- **Package Manager**: Custom package.mk format (no apt/rpm/etc.)

## Directory Structure

```
LibreELEC.tv/
├── config/               # Build system configuration
│   ├── functions         # Core shell functions (1900+ lines)
│   ├── options           # Main build options loader
│   ├── arch.*            # Architecture-specific settings
│   └── path              # Path configuration
├── distributions/        # Distribution configurations
│   └── LibreELEC/
│       ├── options       # Distribution-wide settings
│       ├── version       # Version information
│       └── kernel_options
├── packages/             # All software packages
│   ├── addons/           # Kodi addon packages
│   ├── emulation/        # Emulator cores (libretro)
│   ├── linux/            # Linux kernel
│   ├── mediacenter/      # Kodi and related
│   ├── virtual/          # Meta-packages (dependencies only)
│   └── [category]/       # Other package categories
├── projects/             # Hardware platform configs
│   ├── Generic/          # x86_64 PCs
│   ├── RPi/              # Raspberry Pi
│   ├── Rockchip/         # Rockchip SoCs
│   ├── Amlogic/          # Amlogic SoCs
│   └── [platform]/
│       ├── options       # Project-level options
│       ├── devices/      # Device-specific configs
│       │   └── [device]/
│       │       └── options
│       ├── linux/        # Kernel configs
│       ├── packages/     # Project-specific packages
│       └── patches/      # Project-specific patches
├── scripts/              # Build scripts
│   ├── build             # Package build script
│   ├── image             # Image creation script
│   ├── install           # Package installation
│   ├── unpack            # Source extraction
│   └── mkimage           # Final image assembly
└── tools/                # Development tools
    ├── docker/           # Docker build environments
    └── pkgcheck          # Package validation tool
```

## Build System

### Build Commands

```bash
# Basic build (creates release image)
PROJECT=Generic ARCH=x86_64 make image

# Build specific platform
PROJECT=RPi DEVICE=RPi4 ARCH=arm make image

# Build with device variant
PROJECT=Rockchip DEVICE=RK3588 ARCH=aarch64 make image

# Build specific package only
PROJECT=Generic ARCH=x86_64 ./scripts/build kodi

# Clean build
make clean        # Remove build artifacts
make distclean    # Full clean including downloads
```

### Docker Build

```bash
# Build Docker image
docker build --pull -t libreelec tools/docker/noble

# Run build in container
docker run --rm -v `pwd`:/build -w /build -it \
  -e PROJECT=RPi -e DEVICE=RPi4 -e ARCH=arm \
  libreelec make image
```

### Build Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `PROJECT` | Target platform | `Generic`, `RPi`, `Rockchip` |
| `DEVICE` | Specific device (if applicable) | `RPi4`, `RK3588` |
| `ARCH` | Target architecture | `x86_64`, `arm`, `aarch64` |
| `DISTRO` | Distribution name | `LibreELEC` (default) |
| `DEBUG` | Debug build | `yes`, `kodi+`, `all` |
| `BUILD_SUFFIX` | Build identifier suffix | Custom string |

### Configuration Hierarchy

Options are loaded in this order (later overrides earlier):
1. `config/options` - Base system options
2. `distributions/${DISTRO}/options` - Distribution options
3. `projects/${PROJECT}/options` - Project options
4. `projects/${PROJECT}/devices/${DEVICE}/options` - Device options
5. `config/arch.${TARGET_ARCH}` - Architecture defaults

## Package Development

### Package Structure

Each package lives in `packages/[category]/[name]/` with:
```
package-name/
├── package.mk           # Required: Package definition
├── patches/             # Optional: Patches to apply
│   └── *.patch
├── config/              # Optional: Configuration files
├── scripts/             # Optional: Helper scripts
└── source/              # Optional: Additional source files
```

### package.mk Template

```bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="example-package"
PKG_VERSION="1.2.3"
PKG_SHA256="abc123..."
PKG_LICENSE="GPL"
PKG_SITE="https://example.com"
PKG_URL="https://example.com/releases/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="Description of what this package provides."

# Optional: Build configuration
PKG_TOOLCHAIN="cmake"           # auto, cmake, meson, configure, make, manual
PKG_BUILD_FLAGS="+speed -gold"  # Build optimizations

# Optional: CMake options
PKG_CMAKE_OPTS_TARGET="-DENABLE_FEATURE=ON \
                       -DDISABLE_OTHER=OFF"

# Optional: Override build steps
post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share/doc
}
```

### Required Variables

| Variable | Description |
|----------|-------------|
| `PKG_NAME` | Package name (lowercase) |
| `PKG_VERSION` | Version or git commit hash |
| `PKG_SHA256` | Checksum of source archive |
| `PKG_LICENSE` | Software license |
| `PKG_SITE` | Project homepage |
| `PKG_URL` | Download URL |
| `PKG_LONGDESC` | Package description |

### Toolchain Options

| Toolchain | Build System |
|-----------|--------------|
| `auto` | Auto-detect (default) |
| `meson` | Meson build system |
| `cmake` | CMake with Ninja |
| `cmake-make` | CMake with Make |
| `configure` | GNU Autoconf |
| `autotools` | Autoreconf + configure |
| `make` | Plain Makefile |
| `manual` | Custom build steps only |

### Build Flags

| Flag | Default | Description |
|------|---------|-------------|
| `+pic` | off | Position Independent Code |
| `+speed` | off | Optimize for speed (-O3) |
| `+size` | off | Optimize for size (-Os) |
| `+lto` | off | Link Time Optimization |
| `-parallel` | on | Disable parallel build |
| `-strip` | on | Don't strip binaries |
| `-gold` | on | Don't use gold linker |

### Build Functions

Override these in package.mk for custom behavior:

```bash
# Pre/post hooks for each stage
pre_configure_target()     # Before configure
configure_target()         # Custom configure (replaces default)
post_configure_target()    # After configure

pre_make_target()          # Before make
make_target()              # Custom make
post_make_target()         # After make

pre_makeinstall_target()   # Before install
makeinstall_target()       # Custom install
post_makeinstall_target()  # After install (most common)

post_install()             # After all installation (enable services here)
```

### Late Binding Variables

These variables are only available inside functions, not at package load time:

- `PKG_BUILD` - Build directory path
- `INSTALL` - Installation directory
- `SYSROOT_PREFIX` - Cross-compilation sysroot
- `TARGET_CFLAGS`, `TARGET_LDFLAGS` - Compiler flags

Use `configure_package()` for late variable assignment:

```bash
configure_package() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/subdir/CMakeLists.txt"
}
```

## Project/Device Configuration

### Creating a New Device

1. Create directory: `projects/${PROJECT}/devices/${DEVICE}/`
2. Create `options` file with device-specific settings:

```bash
# Device CPU/Architecture
case $TARGET_ARCH in
  aarch64)
    TARGET_CPU="cortex-a76"
    TARGET_CPU_FLAGS="+crc+crypto"
    ;;
esac

# Kernel configuration
LINUX="default"                    # or custom kernel name
KERNEL_TARGET="Image"              # Kernel output format

# Graphics
GRAPHIC_DRIVERS="panfrost"         # GPU driver

# Boot arguments
EXTRA_CMDLINE="console=ttyS0,115200"

# Additional packages
ADDITIONAL_PACKAGES+=" custom-tool"
```

### Project Options Reference

| Option | Description |
|--------|-------------|
| `TARGET_CPU` | GCC -mcpu value |
| `TARGET_CPU_FLAGS` | Additional CPU flags |
| `LINUX` | Kernel variant name |
| `KERNEL_TARGET` | Kernel build target (Image, bzImage, uImage) |
| `BOOTLOADER` | Boot system (u-boot, syslinux, bcm2835-bootloader) |
| `GRAPHIC_DRIVERS` | GPU drivers (mesa, panfrost, nvidia) |
| `DISPLAYSERVER` | Display backend (no, x11, wl) |

## Common Tasks

### Adding a New Package

1. Create package directory and package.mk
2. Add to dependency tree via virtual package or another package's `PKG_DEPENDS_TARGET`
3. Validate with `./tools/pkgcheck packages/category/new-package`
4. Test build: `./scripts/build new-package`

### Updating a Package

1. Update `PKG_VERSION` and `PKG_SHA256`
2. Check/update patches in `patches/` directory
3. Test build: `./scripts/build package-name`

### Adding Patches

Place patches in `packages/[category]/[name]/patches/`:
- Named with numeric prefix for order: `001-fix-build.patch`
- Must apply cleanly with `patch -p1`
- Project-specific patches: `projects/${PROJECT}/patches/${PKG_NAME}/`
- Device-specific patches: `projects/${PROJECT}/devices/${DEVICE}/patches/${PKG_NAME}/`

### Enabling Kernel Modules

For packages building kernel modules:
```bash
PKG_IS_KERNEL_PKG="yes"
PKG_DEPENDS_TARGET="toolchain linux"
```

### Creating Addons

Set addon-specific variables:
```bash
PKG_IS_ADDON="yes"           # or "embedded" for built-in
PKG_REV="100"                # Addon revision (increment for updates)
PKG_ADDON_NAME="My Addon"
PKG_ADDON_TYPE="xbmc.python.pluginsource"
```

## Code Conventions

### Shell Script Style

- Use `#!/bin/bash` shebang
- Quote variables: `"${VAR}"` not `$VAR`
- Use `[[ ]]` for conditionals
- Functions: `function_name() { ... }`
- Indent with 2 spaces

### Package Naming

- Package names: lowercase, hyphens for separation
- Version: semantic versioning or full git commit hash
- Source archives: `${PKG_NAME}-${PKG_VERSION}.tar.gz`

### Commit Messages

- One feature/fix per commit
- Clear, descriptive message
- Reference issues if applicable

## Testing and Validation

### Package Validation

```bash
# Check package.mk for issues
./tools/pkgcheck packages/path/to/package

# Checks performed:
# - Late binding violations
# - Duplicate function definitions
# - Unknown functions
# - Syntax issues
```

### Build Testing

```bash
# Build single package
./scripts/build package-name

# Build with verbose output
VERBOSE=yes ./scripts/build package-name

# Clean and rebuild
./scripts/clean package-name
./scripts/build package-name
```

### Reporting Build Failures

Before reporting, always:
1. Run `make clean`
2. Use unmodified git clone
3. Include full build log
4. Specify PROJECT, DEVICE, ARCH

## Useful Commands

```bash
# Show build configuration
PROJECT=Generic ARCH=x86_64 . config/options && . config/show_config

# List available packages
ls packages/*/

# Find package by name
find packages -name "package.mk" | xargs grep -l "PKG_NAME=\"search-term\""

# Check package dependencies
grep -r "PKG_DEPENDS" packages/category/package/package.mk

# View kernel config location
# projects/${PROJECT}/linux/ or projects/${PROJECT}/devices/${DEVICE}/linux/

# Build artifacts location
# build.${DISTRO}-${PROJECT}.${DEVICE:-${PROJECT}}.${ARCH}[-${BUILD_SUFFIX}]/
```

## Important Files Reference

| File | Purpose |
|------|---------|
| `config/functions` | Core build system functions |
| `config/options` | Main configuration loader |
| `scripts/build` | Package build orchestration |
| `scripts/image` | Image creation entry point |
| `scripts/mkimage` | Final image assembly |
| `packages/readme.md` | Detailed package.mk documentation |
| `CONTRIBUTING.md` | Contribution guidelines |

## Emulation Support

This fork includes extensive emulation support via libretro cores in `packages/emulation/`. Key packages:
- `libretro-*` - Various emulator cores
- `retroarch` - Frontend (if present)

## Notes for AI Assistants

1. **Always read before editing**: Use the Read tool before modifying any file
2. **Respect the build system**: Don't introduce non-standard patterns
3. **Test changes**: Provide commands to validate changes
4. **Package dependencies**: Check `PKG_DEPENDS_TARGET` chains
5. **Late binding**: Remember toolchain variables are only valid in functions
6. **Cross-compilation**: This builds for target architecture, not host
7. **No root builds**: Build system refuses to run as root
8. **Path restrictions**: No spaces in build paths

## Quick Reference Card

```bash
# Environment setup
export PROJECT=Generic ARCH=x86_64

# Build commands
make image              # Full image build
make clean              # Clean build
./scripts/build PKG     # Build single package
./scripts/clean PKG     # Clean single package

# Key paths
packages/               # All packages
projects/               # Platform configs
distributions/          # Distro configs
build.*/                # Build output

# Package essentials
PKG_NAME, PKG_VERSION, PKG_SHA256, PKG_URL
PKG_DEPENDS_TARGET, PKG_TOOLCHAIN
post_makeinstall_target()  # Most common override
```
