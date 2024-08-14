{
  services.mako = {
    enable = true;
    maxVisible = 5;
    sort = "-time";
    layer = "overlay";
    anchor = "bottom-right";
    font = "Noto Sans";
    backgroundColor = "#1e1e2eee";
    textColor = "#cdd6f4";
    width = 350;
    height = 300;
    margin = "10";
    padding = "15";
    borderSize = 3;
    borderColor = "#89b4fa";
    borderRadius = 10;
    progressColor = "over #313244";
    icons = true;
    maxIconSize = 48;
    markup = true;
    actions = true;
    defaultTimeout = 5000;
    ignoreTimeout = false;
    extraConfig = ''
      history=true
      text-alignment=left
      icon-location=left

      [urgency=low]
      border-color=#A6E3A1
      default-timeout=5000

      [urgency=normal]
      border-color=#89b4fa
      default-timeout=5000

      [urgency=high]
      border-color=#fab387
      text-color=#f38ba8
      default-timeout=0
    '';
  };
}
