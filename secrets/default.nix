{ inputs
, ...
}: {
  imports = [
     inputs.ragenix.nixosModules.default
  ];

  environment.systemPackages = [ inputs.ragenix.packages.x86_64-linux.default ];

  age = {
    identityPaths = [
      "/persistent/etc/ssh/ssh_host_ed25519_key"
    ];

    secrets = {
      "login-password" = {
        file = "${inputs.mysecrets}/login-password.age";
        mode = "0000";
        owner = "sickle-phin";
      };
    };
  };
}
