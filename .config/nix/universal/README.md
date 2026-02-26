# Using nix

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

- Once cloned remember for update your user name [here](./flake.nix#L14).

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
  sudo darwin-rebuild switch --flake .#mac-arm
  ```

### Restart nix in mac

```sh
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo launchctl start org.nixos.nix-daemon
```

### Setup Custom enterprise certs with Darwin (MAC)

[ref](https://nix.dev/manual/nix/2.28/installation/env-variables.html)

```sh
security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o  ~/.certs/ca_cert.pem
export NIX_SSL_CERT_FILE=${HOME}/.certs/ca_cert.pem
echo "ssl-cert-file = ${HOME}/.certs/ca_cert.pem" | sudo tee -a /etc/nix/nix.conf
```
