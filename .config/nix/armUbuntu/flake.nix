{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

  };
}

{
  description = "A development setup in Ubuntu ARM (aarch64-linux)"

  inputs = {
    # Pinning the nixpkgs channel for reproducibility.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Set the system for your ARM machine.
      system = "aarch64-linux";
      pkgs = import nixpkgs { inherit system; };

    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          vim
          neovim
          tmux
          mkalias
          git
          docker
          (google-cloud-sdk.withExtraComponents [
            google-cloud-sdk.components.gke-gcloud-auth-plugin
          ])
          zsh
          pyenv
          autojump
          kubectl
          kubernetes-helm
          terraform
          httpie
          zsh-syntax-highlighting
          zsh-history-substring-search
          zsh-autosuggestions
          gh
          zsh-powerlevel10k
          openssl
          zinit
          stow
          zed-editor
          fzf
          zoxide
          kubectx
          zsh-history-substring-search
          direnv
          nix-direnv
          jq
          nodejs_22
          python3
          mas
          helix
          helix-gpt
          confluent-cli
          ripgrep
          fd
          bat
          zellij
          colorls
          lazygit
          mongosh
          inetutils
          mongodb-tools
          claude-code
          rustc
          code-cursor
          uv
          ollama
          k9s
        ];

        # Set a hook to automatically launch Zsh when you enter the shell.
        shellHook = ''
          echo "Entering Zsh shell with Node.js and Python available."
          exec zsh
        '';
      };
    };
}


outputs = inputs@{ self, nixpkgs}:
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
      pkgs.claude-code
      pkgs.rustc
      pkgs.code-cursor
      pkgs.uv
      pkgs.ollama
      pkgs.k9s
    ];
    fonts.packages = with pkgs; [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.meslo-lg
      pkgs.meslo-lgs-nf
    ];

    system = {
      primaryUser = "nvidia";
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
    nixpkgs.hostPlatform = "aarch64-linux";


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
          user = "admin";
          # Automatically migrate existing Homebrew installations
          autoMigrate = true;
        };
      }
    ];
  };
};
}
