{
  config,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  age = {
    identityPaths = lib.mkMerge [
      (lib.mkIf (config.networking.hostName != "labo") [ "/persistent/etc/ssh/ssh_host_ed25519_key" ])
      (lib.mkIf (config.networking.hostName == "labo") [ "/etc/ssh/ssh_host_ed25519_key" ])
    ];

    secrets = {
      "login-password" = {
        file = "${inputs.mysecrets}/login-password.age";
        mode = "0000";
        owner = "root";
      };
    };
  };
}
