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
          key = "╰─ 󱫐 ";
          keyColor = "cyan";
        }
        {
          type = "cpu";
          key = "╭─  ";
          keyColor = "yellow";
        }
        {
          type = "gpu";
          key = "├─  ";
          keyColor = "yellow";
        }
        {
          type = "display";
          key = "├─ 󱄄 ";
          keyColor = "yellow";
        }
        {
          type = "memory";
          key = "├─  ";
          keyColor = "yellow";
        }
        {
          type = "disk";
          key = "├─  ";
          keyColor = "yellow";
        }
        {
          type = "swap";
          key = "╰─ 󰓡 ";
          keyColor = "yellow";
        }
        {
          type = "wm";
          key = "╭─  ";
          keyColor = "red";
        }
        {
          type = "terminal";
          key = "├─  ";
          keyColor = "red";
        }
        {
          type = "shell";
          key = "╰─  ";
          keyColor = "red";
        }
        "break"
        {
          type = "custom";
          format = " {#90}  {#31}  {#32}  {#33}  {#34}  {#35}  {#36}  {#37} ";
        }
      ];
    };
  };
}
