{
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.agenix.nixosModules.default ];

  environment.systemPackages = [ inputs.agenix.packages.x86_64-linux.default ];

  age = {
    identityPaths =
      if config.preservation.enable then
        [ "/persistent/etc/ssh/ssh_host_ed25519_key" ]
      else
        [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      "login-password" = {
        file = "${inputs.mysecrets}/login-password.age";
        mode = "0000";
        owner = "root";
      };
    };
  };
}
