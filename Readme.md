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
    git clone https://github.com/dozr/dotfiles
  ```
- Install packages with nix
  ```sh
    nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/.config/nix/armMac#armMac
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
    git clone https://github.com/dozr/dotfiles
    nix run nix-darwin/master --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/.config/nix/armMac#armMac
    cd dotfiles
    stow --adopt .
```

### Refrence
- [nix-darwin](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI)
- [neovim](https://typecraft.dev/neovim-for-newbs)
- [GNU stow](https://www.youtube.com/watch?v=Z8BL8mdzWHI) 

