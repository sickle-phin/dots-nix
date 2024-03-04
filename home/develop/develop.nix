{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gnumake
    rustup
    nodejs
    deno
  ];
}
