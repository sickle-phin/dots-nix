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

      config.enable_tab_bar = false
      config.font = wezterm.font_with_fallback({
          {
            family = "Moralerspace Neon HW",
            harfbuzz_features = { 'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09' }
          },
          { family = "Apple Color Emoji" },
      })
      config.font_size = 18.0
      config.front_end = "WebGpu"
      config.term = "wezterm"
      config.underline_position="-3pt"
      config.underline_thickness="2pt"
      config.webgpu_power_preference = "HighPerformance"
      config.window_background_opacity = 0.85

      return config
    '';
  };
}
