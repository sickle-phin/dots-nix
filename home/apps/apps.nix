{ pkgs,
  ...
}: {
  home.packages = with pkgs; [
    imv
    neovide
    onlyoffice-bin_latest
    pavucontrol
    playerctl
    thunderbird
    zoom-us
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
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
        hwdec = "no"; # HW対応、デフォルト値は"no"
        vo = "gpu";
        loop-playlist="inf"; # 再生終了後に最初から再生し直す(プレイリスト単位)

        # mpvでYouTubeの視聴をしたい場合はyoutube-dlが必要だが
	# 代わりにyt-dlpを使いたい場合にはこのように定義する(yt-dlpは別項目でインストールしておくこと)
        # script-opts="ytdl_hook-ytdl_path=${pkgs.yt-dlp}/bin/yt-dlp";
      };
    };
  };
}
