{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    gcc
    gnumake
    rustup
    nodejs
    yarn
    deno
  ];
}
