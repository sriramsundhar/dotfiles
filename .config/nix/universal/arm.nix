{ nix-darwin, nixpkgs, mac-app-util, nix-homebrew, configuration, currentUser }: nix-darwin.lib.darwinSystem {
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
        user = currentUser;
        # Automatically migrate existing Homebrew installations
        autoMigrate = true;
      };
    }
    ({ pkgs, ... }: {
      nixpkgs.hostPlatform = "aarch64-darwin";
    })
  ];
}
