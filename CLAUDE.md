# CLAUDE.md - AI Assistant Guide for LibreELEC.tv

## Project Overview

LibreELEC is a "Just enough OS" Linux distribution for the Kodi media center software. This repository contains the complete build system for creating LibreELEC images for various hardware platforms.

**Key Characteristics:**
- Builds a minimal Linux distribution optimized for running Kodi
- Supports multiple architectures: x86_64, arm, aarch64
- Cross-compilation build system with toolchain generation
- Package-based architecture with ~500+ packages
- Supports multiple hardware projects: Generic (x86), Raspberry Pi, Amlogic, Rockchip, Allwinner, Samsung, NXP, Qualcomm

## Directory Structure

```
LibreELEC.tv/
├── config/              # Build system configuration
│   ├── functions        # Core shell functions (~60k lines)
│   ├── options          # Build options loader
│   ├── arch.*          # Architecture-specific settings
│   ├── graphic         # Graphics driver configuration
│   ├── path            # Path definitions
│   └── show_config     # Configuration display
├── distributions/       # Distribution configurations
│   └── LibreELEC/      # Main distribution
│       ├── options     # Distribution-wide options
│       └── version     # Version information
├── packages/           # All software packages (~500+)
│   ├── addons/         # Kodi addons
│   ├── devel/          # Development tools
│   ├── emulation/      # Emulation/RetroArch cores
│   ├── graphics/       # Graphics libraries
│   ├── linux/          # Kernel and modules
│   ├── mediacenter/    # Kodi and related
│   ├── multimedia/     # Audio/video libraries
│   ├── network/        # Networking packages
│   ├── sysutils/       # System utilities
│   ├── virtual/        # Meta-packages (dependencies only)
│   └── ...
├── projects/           # Hardware platform definitions
│   ├── Generic/        # x86_64 PC
│   ├── RPi/            # Raspberry Pi
│   ├── Amlogic/        # Amlogic SoCs
│   ├── Rockchip/       # Rockchip SoCs
│   ├── Allwinner/      # Allwinner SoCs
│   └── ...
├── scripts/            # Build scripts
│   ├── build           # Main package build script
│   ├── image           # Image creation script
│   ├── unpack          # Source unpacking
│   ├── install         # Package installation
│   ├── checkdeps       # Dependency checker
│   └── ...
├── tools/              # Development utilities
│   ├── docker/         # Docker build environments
│   ├── pkgcheck        # Package validation tool
│   ├── mkpkg/          # Package creation helpers
│   └── ...
└── Makefile            # Main build entry point
```

## Build System

### Basic Build Commands

```bash
# Build a release image (default: Generic x86_64)
make release

# Build with specific project/device/architecture
PROJECT=RPi DEVICE=RPi4 ARCH=arm make image

# Build for Amlogic devices
PROJECT=Amlogic DEVICE=AMLGX ARCH=aarch64 make image

# Clean build artifacts
make clean

# Full clean including toolchain
make distclean
```

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PROJECT` | Hardware platform | Generic |
| `DEVICE` | Specific device variant | (varies) |
| `ARCH` | Target architecture | x86_64 |
| `DISTRO` | Distribution name | LibreELEC |
| `BUILD_WITH_DEBUG` | Enable debug build | no |

### Docker Build

```bash
# Build Docker image
docker build --pull -t libreelec tools/docker/noble

# Build LibreELEC inside container
docker run --rm -v `pwd`:/build -w /build -it libreelec make image

# Build specific target
docker run --rm -v `pwd`:/build -w /build -it \
  -e PROJECT=RPi -e DEVICE=RPi4 -e ARCH=arm libreelec make image
```

## Package System

### Package Structure

Each package lives in `packages/<category>/<name>/` with a `package.mk` file:

```bash
packages/
└── category/
    └── package-name/
        ├── package.mk       # Package definition (required)
        ├── patches/         # Patch files (optional)
        └── config/          # Configuration files (optional)
```

### package.mk Required Variables

```bash
PKG_NAME="package-name"           # Package name (lowercase)
PKG_VERSION="1.2.3"               # Version or git hash
PKG_SHA256="abc123..."            # SHA256 of download
PKG_LICENSE="GPL"                 # License type
PKG_SITE="https://example.com"    # Project website
PKG_URL="https://.../v1.2.3.tar.gz"  # Download URL
PKG_DEPENDS_TARGET="toolchain"    # Build dependencies
PKG_LONGDESC="Description..."     # Package description
```

### Toolchain Options

| Toolchain | Description |
|-----------|-------------|
| `auto` | Auto-detect (default) |
| `meson` | Meson build system |
| `cmake` | CMake with Ninja |
| `cmake-make` | CMake with Make |
| `configure` | Pre-configured autotools |
| `autotools` | Full autotools (runs autoreconf) |
| `make` | Plain Makefile |
| `manual` | Custom build steps only |

### Build Flags

```bash
PKG_BUILD_FLAGS="+pic -gold +lto"
```

| Flag | Description |
|------|-------------|
| `pic` | Position Independent Code |
| `lto` | Link Time Optimization |
| `speed` | Optimize for speed (-O3) |
| `size` | Optimize for size (-Os) |
| `gold` | Use gold linker |
| `mold` | Use mold linker |
| `strip` | Strip binaries (default: on) |
| `parallel` | Parallel build (default: on) |

### Package Functions

Override these functions in package.mk for custom behavior:

```bash
# Configuration phase
pre_configure_target()
configure_target()
post_configure_target()

# Build phase
pre_make_target()
make_target()
post_make_target()

# Install phase
pre_makeinstall_target()
makeinstall_target()
post_makeinstall_target()

# Late binding setup
configure_package()
```

Replace `_target` with `_host`, `_init`, or `_bootstrap` for other build stages.

### Late Binding Variables

These variables are only available inside functions, not at global scope:

- `PKG_BUILD` - Build directory path
- `SYSROOT_PREFIX` - Sysroot path
- `INSTALL` - Installation directory
- All compiler variables (`CC`, `CXX`, `CFLAGS`, etc.)

### Virtual Packages

Packages in `packages/virtual/` only define dependencies (PKG_SECTION="virtual"):

```bash
PKG_NAME="image"
PKG_SECTION="virtual"
PKG_DEPENDS_TARGET="linux busybox kodi ..."
```

## Projects and Devices

### Project Structure

```
projects/<Project>/
├── options              # Project-wide options
├── linux/               # Kernel configs
├── patches/             # Project-specific patches
├── packages/            # Project-specific package overrides
├── filesystem/          # Root filesystem additions
├── bootloader/          # Bootloader configs
└── devices/             # Device variants
    └── <Device>/
        ├── options      # Device-specific options
        ├── linux/       # Device kernel config
        └── ...
```

### Available Projects

| Project | Architecture | Description |
|---------|--------------|-------------|
| Generic | x86_64 | Standard PC/HTPC |
| RPi | arm/aarch64 | Raspberry Pi |
| Amlogic | aarch64 | Amlogic SoC devices |
| Rockchip | aarch64 | Rockchip SoC devices |
| Allwinner | aarch64 | Allwinner SoC devices |
| Samsung | aarch64 | Samsung Exynos |
| NXP | aarch64 | NXP i.MX |
| Qualcomm | aarch64 | Qualcomm Snapdragon |

## Development Workflows

### Adding a New Package

1. Create directory: `packages/<category>/<package-name>/`
2. Create `package.mk` using template from `packages/packages.mk.template`
3. Add to dependency tree via virtual package or existing package's `PKG_DEPENDS_TARGET`
4. Validate with: `tools/pkgcheck packages/<category>/<package-name>/package.mk`
5. Build: `scripts/build <package-name>`

### Updating a Package

1. Update `PKG_VERSION` in package.mk
2. Update `PKG_SHA256` (download and hash new source)
3. Refresh patches if needed: `tools/refresh-patches <package>`
4. Test build: `scripts/build <package-name>`

### Creating an Addon

1. Use template: `packages/packages.mk.addon_template`
2. Set addon-specific variables:
   ```bash
   PKG_REV="100"           # Addon revision (increment for updates)
   PKG_IS_ADDON="yes"
   PKG_ADDON_NAME="My Addon"
   PKG_ADDON_TYPE="xbmc.python.pluginsource"
   ```
3. Implement `addon()` function to install files

### Build Individual Package

```bash
# Build single package
scripts/build <package-name>

# Build with specific target
scripts/build <package-name>:target
scripts/build <package-name>:host
```

## Key Conventions

### Code Style

- Shell scripts use bash
- 2-space indentation in shell scripts
- Package names are lowercase with hyphens
- Use full git hashes for `PKG_VERSION` when using git sources

### Patch Naming

Patches in `packages/<pkg>/patches/` are applied alphabetically:
```
0001-fix-compilation.patch
0002-add-feature.patch
```

### Important Files

- `config/functions` - Core build system functions
- `config/options` - Main options loader
- `scripts/build` - Package build orchestration
- `scripts/image` - Image creation

### Testing Changes

1. Run `tools/pkgcheck` on modified packages
2. Do a clean build: `make clean && make image`
3. Test on actual hardware or VM

### Common Issues

- **Late binding violations**: Don't reference `PKG_BUILD`, `SYSROOT_PREFIX`, etc. at global scope
- **Missing dependencies**: Add to `PKG_DEPENDS_TARGET`
- **Build failures after update**: Run `make clean` first
- **Patch failures**: Refresh patches with `tools/refresh-patches`

## Tools Reference

| Tool | Purpose |
|------|---------|
| `tools/pkgcheck` | Validate package.mk files |
| `tools/update-pkg` | Update package versions |
| `tools/distro-tool` | Distribution management |
| `tools/mkpkg/` | Package creation helpers |
| `scripts/checkdeps` | Check host dependencies |

## Build Output

Build artifacts are created in:
- `build.<project>.<device>.<arch>/` - Build directory
- `target/` - Final images
- `sources/` - Downloaded sources (cached)

## Version Information

- **OS Version**: 13.0
- **Distribution**: LibreELEC
- **Kodi Version**: Current development branch
- **License**: GPLv2

## Additional Resources

- [LibreELEC Wiki](https://wiki.libreelec.tv)
- [LibreELEC Forum](https://forum.libreelec.tv)
- [packages/readme.md](packages/readme.md) - Detailed package documentation
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
