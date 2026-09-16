{config, pkgs, inputs, ... }: {
    
    #enable polkit
    security.polkit.enable = true;

    #enable GPG agent
    programs.gnupg.agent = {
        enable = true;
        pinentryPackage = pkgs.pinentry-curses;
        enableSSHSupport = true;
    };

    #Some programs need SUID wrappers, can be configured further or are
    #started in user sessions.
    #programs.mtr.enable = true;
    
}
