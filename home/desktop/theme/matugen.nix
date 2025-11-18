{
  config,
  inputs,
  ...
}:
{
  xdg.configFile = {
    "matugen/config.toml".text = ''
      [config]

      [templates.btop]
      input_path = '${inputs.matugen-themes}/templates/btop.theme'
      output_path = '${config.xdg.configHome}/btop/themes/matugen.theme'
      post_hook = 'pgrep -x btop >/dev/null && pkill -USR2 btop'

      [templates.cava]
      input_path = '${inputs.matugen-themes}/templates/cava-colors.ini'
      output_path = '${config.xdg.configHome}/cava/themes/matugen'
      post_hook = 'pgrep -x cava >/dev/null && pkill -USR2 cava'

      [templates.fcitx5]
      input_path = '${config.xdg.configHome}/matugen/templates/fcitx5.conf'
      output_path = '${config.xdg.dataHome}/fcitx5/themes/matugen/theme.conf'
      post_hook = 'systemctl restart --user fcitx5-daemon.service'
    '';

    "matugen/templates/fcitx5.conf".text = ''
      # vim: ft=dosini
      [Metadata]
      Name=fcitx5 theme
      Version=1.0
      Author=sickle-phin
      Description=fcitx5 dynamic theme
      ScaleWithDPI=True

      [InputPanel]
      Font=Sans 13
      Spacing=3

      # Unselected candidate color
      NormalColor={{colors.on_surface.default.hex}}
      # Selected candidate color
      HighlightCandidateColor={{colors.background.default.hex}}
      # Input character color
      HighlightColor={{colors.primary.default.hex}}
      # Input character background color
      HighlightBackgroundColor={{colors.background.default.hex}}

      [InputPanel/TextMargin]
      Left=18
      Right=18
      Top=8
      Bottom=8

      [InputPanel/Background]
      Color={{colors.background.default.hex}}dd

      # Uncomment this to switch to rounded-corner
      Image=panel.svg

      [InputPanel/Background/Margin]
      Left=10
      Right=10
      Top=10
      Bottom=10

      [InputPanel/Highlight]
      Color={{colors.primary.default.hex}}

      # Uncomment this to switch to rounded-corner
      Image=highlight.svg

      [InputPanel/Highlight/Margin]
      Left=18
      Right=18
      Top=8
      Bottom=8

      [Menu]
      Font=Sans 10
      NormalColor={{colors.on_surface.default.hex}}
      Spacing=3

      [Menu/Background]
      Color={{colors.background.default.hex}}

      [Menu/Background/Margin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/ContentMargin]
      Left=2
      Right=2
      Top=2
      Bottom=2

      [Menu/Highlight]
      Color={{colors.primary.default.hex}}

      [Menu/Highlight/Margin]
      Left=10
      Right=10
      Top=5
      Bottom=5

      [Menu/Separator]
      Color={{colors.background.default.hex}}

      [Menu/CheckBox]
      Image=radio.png

      [Menu/SubMenu]
      Image=arrow.png

      [Menu/TextMargin]
      Left=5
      Right=5
      Top=5
      Bottom=5
    '';
  };
}
