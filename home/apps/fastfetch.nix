{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        {
          type = "os";
          key = "╭─  ";
          keyColor = "cyan";
        }
        {
          type = "kernel";
          key = "├─  ";
          keyColor = "cyan";
        }
        {
          type = "uptime";
          key = "╰─ 󰅐 ";
          keyColor = "cyan";
        }
        {
          type = "cpu";
          key = "╭─ 󰻠 ";
          keyColor = "magenta";
        }
        {
          type = "gpu";
          key = "├─ 󰍛 ";
          keyColor = "magenta";
        }
        {
          type = "display";
          key = "├─ 󰍹 ";
          keyColor = "magenta";
        }
        {
          type = "memory";
          key = "├─ 󰑭 ";
          keyColor = "magenta";
        }
        {
          type = "disk";
          key = "├─  ";
          keyColor = "magenta";
        }
        {
          type = "swap";
          key = "╰─ 󰓡 ";
          keyColor = "magenta";
        }
        {
          type = "wm";
          key = "╭─  ";
          keyColor = "yellow";
        }
        {
          type = "terminal";
          key = "├─  ";
          keyColor = "yellow";
        }
        {
          type = "shell";
          key = "╰─  ";
          keyColor = "yellow";
        }
        "break"
        {
          type = "custom";
          format = " {#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37}";
        }
      ];
    };
  };
}
