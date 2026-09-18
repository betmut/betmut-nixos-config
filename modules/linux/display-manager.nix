{config, pkgs, inputs,...}:{

  services.sysc-greet = {
    enable = true;
    compositor = "niri";  # or "cagebreak", "sway", "hyprland" (deprecated)
    niriPackage = pkgs.niri;
  };

  #services.greetd = {
  #  enable = true;
  #  settings = {
  #    default_session = {
  #      command = let 
  #        theme = "border=magenta;text=cyan;prompt=blue;container=black;greet=cyan;time=lightgreen";
  #        greeting = "das beste oder nichts.";
  #      in
  #      "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland --greeting '${greeting}' --theme '${theme}' --background matrix";
  #      user = "greeter";
  #    };
  #  };
  #};
}
