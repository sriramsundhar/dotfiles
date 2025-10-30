{
  description = "Universal macOS flake for both Intel and ARM";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew }:
    let
      currentUser = builtins.getEnv "USER";
      packages = import ./packages.nix;
      homebrew = import ./homebrew.nix;
      fonts = import ./fonts.nix;
      configuration = { pkgs, config,... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowUnstable = true;
        # nixpkgs.config.allowInsecure = true;
        environment.systemPackages = packages { inherit pkgs; };
        homebrew = homebrew;
        fonts.packages = fonts { inherit pkgs; };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;
      programs = {
        direnv.enable = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;
    };
      in
      {
        darwinConfigurations."universal-arm" = import ./arm.nix { inherit nix-darwin nixpkgs mac-app-util nix-homebrew configuration currentUser; };
        darwinConfigurations."universal-intel" = import ./intel.nix { inherit nix-darwin nixpkgs mac-app-util nix-homebrew configuration currentUser; };
      };}
