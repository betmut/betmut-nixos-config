{config, pkgs, inputs, ... }: {
  
  #Environment Variables
  environment.variables = {
    EDITOR = "nano";
    LIBVA_DRIVER_NAME = "iHD";
  };
}