{
  programs.satty = {
    enable = true;
    settings = {
      general = {
        resize.mode = "smart";
        floating-hack = true;
      };
      font = {
        family = "Inter Variable";
        style = "Bold";
        fallback = [
          "Noto Sans CJK JP"
        ];
      };
    };
  };
}
