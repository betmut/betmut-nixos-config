{config, pkgs-stable, inputs, ...} : {

  services.rstudio-server = {
    enable = true; #set to true if you want to enable rstudio-server
    listenAddr = "127.0.0.1";
    package = pkgs-stable.rstudioServerWrapper.override { 
      packages = with pkgs-stable.rPackages; [ 
        tidyverse 
      ]; 
    };
  };
}