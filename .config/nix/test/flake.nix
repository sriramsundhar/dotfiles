outputs = { self, nixpkgs, ... }: {
  username = builtins.trace "Logging username" (builtins.baseNameOf (builtins.getEnv "HOME"));
};

