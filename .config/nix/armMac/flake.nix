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
      nixpkgs.config.allowUnstable = true;
      # nixpkgs.config.allowInsecure = true;
      environment.systemPackages = [
        pkgs.vim
        pkgs.neovim
        pkgs.tmux
        pkgs.mkalias
        pkgs.alacritty
        pkgs.git
        pkgs.docker
        (pkgs.google-cloud-sdk.withExtraComponents [
          pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
        ])
        pkgs.zsh
        pkgs.pyenv
        pkgs.autojump
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
        pkgs.fzf
        pkgs.zoxide
        pkgs.kubectx
        pkgs.zsh-history-substring-search
        # pkgs.ghostty
        pkgs.kitty
        pkgs.wezterm
        pkgs.warp-terminal
        pkgs.direnv
        pkgs.nix-direnv
        pkgs.jq
        pkgs.nodejs_22
        pkgs.python3
        pkgs.mas
        pkgs.helix
        pkgs.helix-gpt
        pkgs.confluent-cli
        pkgs.ripgrep
        pkgs.fd
        pkgs.bat
        pkgs.zellij
        pkgs.colorls
        pkgs.lazygit
        pkgs.mongosh
        pkgs.inetutils
        pkgs.mongodb-tools
        pkgs.iterm2
      ];
      homebrew = {
        enable = true;
        brews = [
          "nvm"
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
      fonts.packages = with pkgs; [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.meslo-lg
        pkgs.meslo-lgs-nf
      ];

      system.defaults = {
        dock.autohide = true;
      };


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

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";


    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#darmMac
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
