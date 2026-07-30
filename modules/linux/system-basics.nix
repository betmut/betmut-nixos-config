{config, pkgs, inputs, lib, ... }: {
  
  # Host platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  #Timezone
  time.timeZone = "Asia/Jakarta";

  # Keyboard layout
  console = {
    keyMap = "us";
    font = "Lat2-Terminus16";
  };

  #Localization
  i18n.defaultLocale = "en_US.UTF-8";

  #pulseaudio config
  services.pulseaudio = {
    enable = false;
    support32Bit = true; #if compatibility with 32-bit applications is desired.
  };
}