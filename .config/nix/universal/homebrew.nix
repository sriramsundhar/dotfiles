{
  enable = true;
  brews = [
    "nvm"
    "akka/brew/akka"
    "herdr"
  ];
  casks = [
    "hammerspoon"
    "iina"
    "vorssaint"
    #"background-music"
  ];
  masApps = {
    # "Slack" = 803453959;
  };
  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
}
