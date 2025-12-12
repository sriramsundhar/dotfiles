# dotfile

## Introduction

Setup up terminal with

- [nix](https://nixos.org/) package manager
- [GNU stow](https://www.gnu.org/)
-

## Pre-requisites

- Git
- curl

## Setup



- Initial Install [nix](https://nixos.org/)
  ```sh
    sh <(curl -L https://nixos.org/nix/install)
  ```
- Clone the repository at the home directory
  ```sh
    cd ~
    git clone https://github.com/sriramsundhar/dotfiles
    cd ~/dotfile/.config/nix/universal
  ```
- Once cloned remember for update your user name [here](./.config/nix/universal/flake.nix#L14).
- Install packages with nix in mac-arm.
  ```sh
  sudo nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake .#arm-mac
  ```
- Install packages with nix in mac-intel
  ```sh
  sudo nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake .#arm-mac
  ```
- Install packages with nix in linux or windows WS
  ```sh
  sudo nix profile install .# --extra-experimental-features "nix-command flakes"
  ```

## Update packages


- To update packages
  ```sh
  nix flake update
  ```
- Use the same command as above for compleating the installation our.
- Once darwin is installed we can use a simpler command as well.
  ```sh
  sudo darwin-rebuild switch --flake .#mar-arm
  ``` 

# Setup the terminal with stow

  ```sh
    cd ~/dotfiles
    stow .
  ```

  - If you have conflicts, you can force stow to overwrite the files
    ```sh
    cd ~/dotfiles
    stow --adopt .
    ```

### Git config
- Change the email and necessary configs in [.gitconfig](./.gitconfig).

### Refrence

- [nix-darwin](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [neovim](https://typecraft.dev/neovim-for-newbs)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
