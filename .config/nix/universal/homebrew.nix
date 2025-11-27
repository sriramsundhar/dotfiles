{
  enable = true;
  brews = [
    "nvm"
  ];
  casks = [
    "hammerspoon"
    "iina"
  ];
  masApps = {
    "Slack" = 803453959;
  };
  onActivation.cleanup = "zap";
  onActivation.autoUpdate = true;
  onActivation.upgrade = true;
}