{ config, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}

      if wezterm.config_builder then
          config = wezterm.config_builder()
      end

      local function fileExists(path)
          local file = io.open(path, "r")
          if file then
              file:close()
              return true
          else
              return false
          end
      end

      local filePath = "${config.xdg.configHome}/wezterm/current_theme.lua"

      if fileExists(filePath) then
          config.color_scheme = require("current_theme")
      else
          config.color_scheme = "catppuccin-mocha"
      end

      config.font_size = 18.0
      -- config.front_end = "WebGpu"
      config.term = "wezterm"
      config.window_background_opacity = 0.85
      config.enable_tab_bar = false
      config.font = wezterm.font_with_fallback({
          { family = "Moralerspace Neon HW" },
          { family = "Apple Color Emoji" },
      })

      return config
    '';
  };
}
