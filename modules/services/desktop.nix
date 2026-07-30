# Bundles desktop UI integration services together 
# (Bluetooth manager, thumbnailers, mDNS network discovery, 
# and power key settings).

{config, pkgs, inputs, ... }: {
  services = {
    # System behavior
    logind.settings.Login.HandlePowerKey = "ignore";
    cloudflare-warp.enable = true;

    # Desktop & Interoperability integration
    blueman.enable = true;
    gvfs.enable = true;
    avahi.enable = true;
    gnome.glib-networking.enable = true;
    tumbler.enable = true;
  };
}
