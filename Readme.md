# dotfile

## Introduction

Setup up terminal with

- [nix](https://nixos.org/) package manager
- [GNU stow](https://www.gnu.org/)

## Setup nix

Follow instructions [here](./.config/nix/universal/README.md).

## Setup the terminal with stow

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
