# Nix Configuration

This directory contains Nix configurations for different operating systems and architectures, managed as Nix Flakes.

## Directory Overview

The primary purpose of this directory is to provide a consistent development environment across multiple machines. It uses Nix to declaratively manage system and user packages.

- **`nix.conf`**: Enables the experimental `nix-command` and `flakes` features, which are required for this setup.
- **`armMac/`**: Contains a comprehensive Nix Darwin configuration for an Apple Silicon Mac. It installs a wide range of development tools, command-line utilities, and GUI applications. It also manages Homebrew packages and fonts.
- **`armUbuntu/`**: Provides a Nix configuration for ARM-based Ubuntu, installing a similar set of command-line tools as the `armMac` configuration to ensure a consistent user environment.
- **`basic/`**: A minimal Nix Darwin configuration that serves as a basic template or starting point.

## Key Files

- **`flake.nix`**: Each subdirectory contains a `flake.nix` file that defines the Nix configuration for that specific environment. These files specify the inputs (like `nixpkgs`), the packages to be installed, and other system settings.

## Building and Running

### Universal macOS

To build and apply the `universal` configuration on a Darwin system, you would run:

For ARM systems:

```sh
darwin-rebuild switch --flake .#universal-arm
```

For Intel systems:

```sh
darwin-rebuild switch --flake .#universal-intel
```

To apply a configuration, you would typically use the `nix` command.

### Nix Darwin (macOS)

To build and apply the `armMac` configuration on a Darwin system, you would run:

```sh
darwin-rebuild switch --flake .#armMac
```

For the `intelMac` configuration:

```sh
darwin-rebuild switch --flake .#intelMac
```

### Nix (Linux)

To use the packages from the `armUbuntu` configuration on a Linux system, you can use the `nix profile install` command:

```sh
nix profile install .#
```

This will install the packages defined in the `armUbuntu/flake.nix` into your user profile.

## Development Conventions

- **Declarative Package Management**: All system and user packages are declaratively managed in the `flake.nix` files. To add or remove a package, you should modify the appropriate `flake.nix` and rebuild the system or profile.
- **Cross-Platform Consistency**: The `armMac` and `armUbuntu` configurations share a similar set of command-line tools to ensure a consistent development experience across macOS and Linux.
- **Experimental Features**: This setup relies on the experimental `nix-command` and `flakes` features of Nix.
