{
  enable = true;
  brews = [
    "nvm"
    "akka/brew/akka"
  ];
  casks = [
    "hammerspoon"
    "iina"
    "docker-desktop"
    #"background-music"
  ];
  masApps = {
    # "Slack" = 803453959;
  };
  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
}
