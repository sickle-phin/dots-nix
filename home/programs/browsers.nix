{
  pkgs,
  config,
  ...
}: {
  programs = {
    google-chrome = {
      enable = true;
      # commandLineArgs = ["--enable-features=TouchpadOverscrollHistoryNavigation"];
      # extensions = [
      #   # {id = "";}  // extension id, query from chrome web store
      # ];
    };

    # firefox = {
    #   enable = true;
    #   profiles.sickle-phin = {};
    # };
  };
}
