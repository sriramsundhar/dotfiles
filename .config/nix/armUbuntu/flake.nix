{
  description = "User profile packages with Zsh, Node.js, and Python.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    pkgsFor = system: import nixpkgs { inherit system; };
    packageNames = [
      "vim"
      "neovim"
      "tmux"
      "mkalias"
      "git"
      "docker"
      "(google-cloud-sdk.withExtraComponents ["
      "  google-cloud-sdk.components.gke-gcloud-auth-plugin"
      "])"
      "zsh"
      "pyenv"
      "autojump"
      "kubectl"
      "kubernetes-helm"
      "terraform"
      "httpie"
      "zsh-syntax-highlighting"
      "zsh-history-substring-search"
      "zsh-autosuggestions"
      "gh"
      "zsh-powerlevel10k"
      "openssl"
      "zinit"
      "stow"
      "zed-editor"
      "fzf"
      "zoxide"
      "kubectx"
      "zsh-history-substring-search"
      "direnv"
      "nix-direnv"
      "jq"
      "nodejs_22"
      "python3"
      "mas"
      "helix"
      "helix-gpt"
      "confluent-cli"
      "ripgrep"
      "fd"
      "bat"
      "zellij"
      "colorls"
      "lazygit"
      "mongosh"
      "inetutils"
      "mongodb-tools"
      "claude-code"
      "rustc"
      "code-cursor"
      "uv"
      "ollama"
      "k9s"
    ];
  in {
    packages = nixpkgs.lib.genAttrs systems (system:
      let
        pkgs = pkgsFor system;

        # dynamically build { zsh = pkgs.zsh; git = pkgs.git; ... }
        selected = builtins.listToAttrs (map (name: {
          inherit name;
          value = pkgs.${name};
        }) packageNames);

        # aggregate env
        default = pkgs.buildEnv {
          name = "user-packages";
          paths = builtins.attrValues selected;
        };
      in
        selected // { inherit default; }
    );
  };
}
