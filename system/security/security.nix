{
  systemd.coredump.enable = false;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    sudo.extraConfig = ''
      Defaults lecture=never
      Defaults badpass_message="🐬💦  Sorry, try again."
    '';
    pam = {
      loginLimits = [
        {
          domain = "*";
          item = "core";
          type = "hard";
          value = "0";
        }
      ];
      services = {
        passwd.text = ''
          password required pam_unix.so sha512 shadow nullok rounds=65536
        '';
        hyprlock.text = "auth include login";
        su.requireWheel = true;
        su-l.requireWheel = true;
        system-login.failDelay.delay = "4000000";
      };
    };
  };
}
