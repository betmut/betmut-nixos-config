{config, pkgs, inputs, ... }: {
  
  # System-wide packages
  environment.systemPackages = with pkgs; [
    tmux 
    tree
    git 
    vim 
    pciutils # Useful for 'lspci'
    quickemu
    cron
    wireguard-tools
    iptables
  ];
}