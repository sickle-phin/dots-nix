{ inputs, ... }:
{
  imports = [ inputs.xremap-flake.nixosModules.default ];
  services.xremap.config = {
    modmap = [
      {
        name = "Global";
        remap = {
          "CapsLock" = "Ctrl_L";
        };
      }
    ];
    # keymap = [
    # ];
  };
}
