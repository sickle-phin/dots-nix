{ pkgs, ... }:
{
  services = {
    greetd = {
      enable = true;
      package = pkgs.greetd.tuigreet;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks";
          user = "greeter";
        };
      };
    };
  };
}
