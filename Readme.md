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

- Install [nix](https://nixos.org/)
  ```sh
    sh <(curl -L https://nixos.org/nix/install)
  ```
- Clone the repository at the home directory
  ```sh
    cd ~
    git clone https://github.com/sriramsundhar/dotfiles
  ```
- Install packages with nix in mac
  ```sh
    nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/.config/nix/armMac#armMac
  ```
- Install packages with nix in ubuntu
  ```sh
    nix profile install .# --extra-experimental-features "nix-command flakes"
  ```
- Setup the terminal with stow

  ```sh
    cd ~/dotfiles
    stow .
  ```

  - If you have conflicts, you can force stow to overwrite the files
    ```sh
    cd ~/dotfiles
    stow --adopt .
    ```

### All together

```sh
  sh <(curl -L https://nixos.org/nix/install)
  cd ~
  git clone https://github.com/sriramsundhar/dotfiles
  nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/.config/nix/armMac#armMac
  cd dotfiles
  stow --adopt .
```

### Git config

- Copy the `.gitconfig.sample` to `.gitconfig`.
- Change the email
- Modify to necessary configs

```sh
cp .gitconfig.sample .gitconfig
stow --adot .
```

### Update flake mac

```sh
nix flake update; nix run nix-darwin -- switch --flake
```

### Refrence

- [nix-darwin](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [neovim](https://typecraft.dev/neovim-for-newbs)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
