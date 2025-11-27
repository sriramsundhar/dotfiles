# Universal Nix Flake

A universal Nix flake for macOS and Linux that provides a consistent development environment on both Intel and ARM architectures.

## Overview

This flake sets up a complete development environment on macOS using the Nix package manager. It's designed to be modular and easy to customize, allowing you to define your preferred packages, fonts, and Homebrew configurations in separate files.

## Features

-   **Universal:** Works on both Intel (`x86_64-darwin`) and ARM (`aarch64-darwin`) Macs.
-   **Modular:** The configuration is split into logical files for packages, Homebrew, fonts, and architecture-specific settings, making it easy to manage and evolve.
-   **Comprehensive Package Set:** Includes a wide range of development tools, command-line utilities, and applications.
-   **Homebrew Integration:** Manages Homebrew packages, casks, and Mac App Store apps.
-   **Dynamic User Configuration:** Automatically detects the current user, so you don't have to hardcode it.

## Installation

### Prerequisites

Before you can use this flake, you need to have the following installed on your macOS system:

1.  **Nix:** Follow the instructions on the [NixOS website](https://nixos.org/download.html) to install Nix.
2.  **Nix Flakes:** Enable the experimental `nix-command` and `flakes` features. You can do this by adding the following line to your `~/.config/nix/nix.conf`:

    ```
    experimental-features = nix-command flakes
    ```

3.  **Nix-Darwin:** This flake uses `nix-darwin` to manage the system configuration. You can install it by following the instructions on the [nix-darwin GitHub repository](https://github.com/LnL7/nix-darwin).

### Installation from Scratch

To install this configuration on a new machine, run one of the following commands from the `universal` directory:

**For ARM Macs:**

```sh
darwin-rebuild switch --flake .#universal-arm
```

**For Intel Macs:**

```sh
darwin-rebuild switch --flake .#universal-intel
```

This will build and activate the configuration, installing all the packages and setting up the system according to the flake.

## Usage

### For macOS Users

**For ARM Macs:**

```sh
darwin-rebuild switch --flake .#universal-arm
```

**For Intel Macs:**

```sh
darwin-rebuild switch --flake .#universal-intel
```

### For Linux Users

To install the packages on a Linux system, you can use the `nix profile install` command:

```sh
nix profile install .#
```

This will install the packages defined in `packages.nix` into your user profile.

### Updating Existing Packages

To update all the packages in your configuration to their latest versions, you first need to update the flake's inputs:

```sh
nix flake update
```

This will fetch the latest versions of `nixpkgs`, `nix-darwin`, and any other inputs defined in your `flake.nix`. After updating the inputs, you can rebuild your system to apply the updates:

**For ARM Macs:**

```sh
darwin-rebuild switch --flake .#universal-arm
```

**For Intel Macs:**

```sh
darwin-rebuild switch --flake .#universal-intel
```

### Installing New Packages

To install new packages, you need to add them to the appropriate configuration file.

1.  **For Nix packages:** Add the package name to the list in `packages.nix`.
2.  **For Homebrew packages:** Add the package name to the `brews` or `casks` list in `homebrew.nix`.

After adding the new packages, rebuild your system to install them:

**For ARM Macs:**

```sh
darwin-rebuild switch --flake .#universal-arm
```

**For Intel Macs:**

```sh
darwin-rebuild switch --flake .#universal-intel
```

## Configuration

This flake is designed to be highly customizable. Here's an overview of the file structure and how you can modify it to fit your needs:

-   **`flake.nix`:** The main flake file. You generally won't need to edit this unless you want to change the overall structure or add new modules.
-   **`packages.nix`:** This file contains a list of Nix packages to be installed. To add or remove packages, simply edit this file.
-   **`homebrew.nix`:** This file defines the Homebrew configuration, including packages to install via `brew`, casks, and Mac App Store apps.
-   **`fonts.nix`:** A list of fonts to be installed on your system.
-   **`arm.nix`:** The configuration specific to ARM Macs.
-   **`intel.nix`:** The configuration specific to Intel Macs.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

---

## Uninstallation

**WARNING:** The following steps will completely remove Nix from your system. This is a destructive and irreversible process. Please make sure you have backed up any important data before proceeding.

To completely remove Nix from your system, you can follow these steps:

1.  **Remove the Nix store:**

    ```sh
    sudo rm -rf /nix
    ```

2.  **Remove Nix configuration files:**

    ```sh
    rm -rf ~/.nix-profile ~/.nix-defexpr ~/.nix-channels
    sudo rm -rf /etc/nix
    ```

3.  **Remove the Nix daemon and services:**

    ```sh
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
    sudo rm /Library/LaunchDaemons/org.nixos.darwin-store.plist
    ```

4.  **Clean up your shell profile:**

    Open your shell profile file (e.g., `~/.zshrc`, `~/.bash_profile`, or `~/.profile`) and remove any lines that source Nix-related files. These lines typically look like this:

    ```sh
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    ```

5.  **Remove the `nix-darwin` entry from `/etc/synthetic.conf`:**

    If you have an entry for `nix` in `/etc/synthetic.conf`, you should remove it.

After completing these steps, Nix should be completely removed from your system. You may need to restart your shell or your computer for all changes to take effect.
