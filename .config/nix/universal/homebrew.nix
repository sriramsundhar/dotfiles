{
  enable = true;
  brews = [
    "nvm"
    "yazi"
  ];
  casks = [
    "hammerspoon"
    "iina"
    "docker-desktop"
    #"background-music"
  ];
  masApps = {
    "Slack" = 803453959;
  };
  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
}
