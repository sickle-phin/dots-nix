{ pkgs
, ...
}:{
  users = {
    users = {
      sickle-phin = {
        isNormalUser = true;
        description = "sickle-phin";
        initialHashedPassword = "$6$MeGf7PiZtuFLm1QG$RSwwGRIJdyERl5v4EDuJxYrARnlAtbLM5bYcySWZ5yuyRboYbOzeP9S2jF48c3rVwjE/159EOqWkhIf7mhAZX0";
        extraGroups = [ "networkmanager" "wheel" "gamemode" "tss" ];
        shell = pkgs.zsh;
        #openssh.authorizedKeys.keys = [
        #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx3Sk20pLL1b2PPKZey2oTyioODrErq83xG78YpFBoj admin@ryan-MBP"
        #];
      };
      root = {
        initialHashedPassword = "$6$8iM5vVsSZpG16VT2$Q1OFNAEthuu9kKWKnZR7SOtSxnjOqJ40gaE2Wo8UtEObuSVID.sdF8nVDdGwp8.Vnua05O9HjeGxhiVXMZHsS.";
      };
    };

    mutableUsers = false;
  };
}
