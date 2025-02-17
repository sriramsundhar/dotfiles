{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util, nix-homebrew }:
  let
    configuration = { pkgs, config,... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages =
        [
          pkgs.vim
          pkgs.neovim
          pkgs.tmux
          pkgs.mkalias
          pkgs.alacritty
          pkgs.git
          pkgs.meslo-lgs-nf
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.google-cloud-sdk
          pkgs.zsh
          pkgs.oh-my-zsh
          pkgs.pyenv
          pkgs.autojump
          # pkgs.kubernetes
          pkgs.kubectl
          pkgs.kubernetes-helm
          pkgs.terraform
          pkgs.httpie
          pkgs.zsh-syntax-highlighting
          pkgs.zsh-history-substring-search
          pkgs.zsh-autosuggestions
          pkgs.gh
          pkgs.zsh-powerlevel10k
          pkgs.openssl
          pkgs.zinit
          pkgs.stow
          pkgs.zed-editor
        ];
      homebrew = {
        enable = true;
        brews = [
          "nvm"
          "mas"
        ];
        casks = [
          "hammerspoon"
          "iina"
        ];
        masApps = {
          "Slack" = 803453959;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };


      system.defaults = {
        dock.autohide = true;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";


    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#dozrMac
    darwinConfigurations."armMac" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;
            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "sriram";
            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
