{ config, pkgs, ... }: {
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "mathewelhans" ];
    };
  };

  # Automatically sync fail2ban state with SSH
  services.fail2ban.enable = config.services.openssh.enable;
}