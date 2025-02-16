# dotfile

### Nix package manager
- Source a new file

```bash
nix run nix-darwin/master#darwin-rebuild --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/.config/nix/dozrMac##dozrMac
```