{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gnumake
    rustup
    nodejs
    yarn
    deno
    python3
  ];
}
