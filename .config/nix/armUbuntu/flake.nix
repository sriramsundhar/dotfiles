# {
#   description = "User profile setup for ARM Ubuntu";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#   };

#   outputs = { self, nixpkgs }:
#     let
#       # Define the systems your flake should support.
#       supportedSystems = [
#         "aarch64-linux"
#         "x86_64-linux"
#       ];
#       # A helper function that takes a function 'f' and a list of 'systems',
#       # then applies 'f' to each system to create an attribute set.
#       forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

#       # Function to define the package list for a specific system.
#       mkPackages = system:
#         let pkgs = nixpkgs.legacyPackages.${system}; in
#         with pkgs; [
#           # Add packages for the profile
#           vim
#           # neovim
#           # tmux
#           # mkalias
#           # git
#           # docker
#           # (google-cloud-sdk.withExtraComponents [
#           #   google-cloud-sdk.components.gke-gcloud-auth-plugin
#           # ])
#           # zsh
#           # pyenv
#           # autojump
#           # kubectl
#           # kubernetes-helm
#           # terraform
#           # httpie
#           # zsh-syntax-highlighting
#           # zsh-history-substring-search
#           # zsh-autosuggestions
#           # gh
#           # zsh-powerlevel10k
#           # openssl
#           # zinit
#           # stow
#           # zed-editor
#           # fzf
#           # zoxide
#           # kubectx
#           # zsh-history-substring-search
#           # direnv
#           # nix-direnv
#           # jq
#           # nodejs_22
#           # python3
#           # mas
#           # helix
#           # helix-gpt
#           # confluent-cli
#           # ripgrep
#           # fd
#           # bat
#           # zellij
#           # colorls
#           # lazygit
#           # mongosh
#           # inetutils
#           # mongodb-tools
#           # claude-code
#           # rustc
#           # code-cursor
#           # uv
#           # ollama
#           # k9s
#         ];

#     in {
#       # The packages output for each system.
#       packages = forAllSystems mkPackages;
#     };
# }
{
  description = "User profile packages with Zsh, Node.js, and Python.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Define the systems your flake should support.
      supportedSystems = [
        "aarch64-linux"
        "x86_64-linux"
      ];

      # A helper function that takes a function 'f' and a list of 'systems',
      # then applies 'f' to each system to create an attribute set.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Function to define the package list for a specific system.
      mkPackages = system:
        let pkgs = nixpkgs.legacyPackages.${system}; in
        with pkgs; [
          # Add packages for the profile
          zsh
          oh-my-zsh
          git
          wget
          nodejs_22
          python311
        ];

    in {
      # The packages output for each system.
      packages = forAllSystems mkPackages;
    };
}
