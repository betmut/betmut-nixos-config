{pkgs, inputs, config, lib, ...}:{

  # Allow proprietary software (Required for Broadcom)
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.18.39"
    ];
  };

  services.fstrim.enable = true; #Enable TRIM
  services.printing.enable = true; #Enable CUPS to print documents.
  services.libinput.enable = true; #Enable touchpad support

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    facetimehd.enable = true;
    enableRedistributableFirmware = true;
  };
}
