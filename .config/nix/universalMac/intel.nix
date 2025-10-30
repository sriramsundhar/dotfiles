{ nix-darwin, nixpkgs, mac-app-util, nix-homebrew, configuration, currentUser }: nix-darwin.lib.darwinSystem {
  modules = [
    configuration
    mac-app-util.darwinModules.default
    nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        # Intel machine doesn't need Rosetta installation
        enableRosetta = false;
        user = currentUser;
        autoMigrate = true;
      };
    }
    # Override host platform for the x86_64 build
    ({ pkgs, ... }: {
      nixpkgs.hostPlatform = "x86_64-darwin";
    })
  ];
}