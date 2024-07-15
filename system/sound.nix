{ inputs
, ...
}:{
  imports = [ inputs.nix-gaming.nixosModules.pipewireLowLatency ];
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    lowLatency = {
      enable = true;
      quantum = 32;
      rate = 96000;
    };
  };
}
