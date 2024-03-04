{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    fastfetch
  ];
  xdg.configFile = {
    "fastfetch/config.jsonc".text = ''
          {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "modules": [
          "title",
          "separator",
          "os",
          "kernel",
          "uptime",
          "shell",
          "display",
          "de",
          "wm",
          "wmtheme",
          "terminal",
          "cpu",
          "gpu",
          "memory",
          "swap",
          "disk",
          "break",
          "colors"
        ]
      }
    '';
  };
}
