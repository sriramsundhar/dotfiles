{
  description = "User profile packages with Zsh, Node.js, and Python.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    pkgsFor = system: import nixpkgs { inherit system; };
    packageNames = [
      "zsh" "oh-my-zsh" "git" "wget" "nodejs_22" "python311"
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
