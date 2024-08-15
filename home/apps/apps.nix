{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    neovide
    pavucontrol
    playerctl
    thunderbird
    zoom-us
  ];

  programs = {
    imv = {
      enable = true;
      catppuccin.enable = true;
    };

    mpv = {
      enable = true;
      catppuccin.enable = true;
      defaultProfiles = [ "gpu-hq" ];
      scripts = with pkgs.mpvScripts; [
        uosc # UIの全体的な改善
        thumbfast # サムネイルの表示
        mpv-playlistmanager # Shift + Enterでプレイリストを表示
        mpris
      ];
      scriptOpts = {
        # thumbfast.network = "yes"; # YouTubeのサムネイルを表示する設定だが実用性はイマイチ
        # playlistmanager.key_showplaylist = "F8"; # プレイリスト表示のショートカットキーを変更したい場合
      };
      config = {
        hwdec = "no";
        vo = "gpu";
        loop-playlist = "inf";
      };
    };

    sioyek = {
      enable = true;
    };
  };
}
