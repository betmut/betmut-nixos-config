{config, pkgs, inputs, ... }: {

  # Broadcom BCM4360 for MacBook's WiFi module dan zSwap for optimizing memory
  boot = {
    initrd.availableKernelModules = ["xhci_pci" "nvme" "usb_storage" "usbhid" "sd_mod"];
    initrd.kernelModules = [ "wl" "i915" "lz4"];
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_xanmod; #optimized linux kernel
    kernelModules = [ "wl" "kvm-intel"];
    kernelParams = [
      "zswap.enabled=1" # enables zswap
      "zswap.compressor=lz4" # compression algorithm
      "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
      "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };
}