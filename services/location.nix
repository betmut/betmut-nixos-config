{config, pkgs, inputs, ... }: {

  #geoclue2 for location services    
  services.geoclue2 = {
    enable = true;
    geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
    enableWifi = true;
  };

  # Set Geoclue as the default location provider
  location.provider = "geoclue2";

}