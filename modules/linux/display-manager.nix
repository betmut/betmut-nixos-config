{config, pkgs,...}:{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = let 
          theme = "border=magenta;text=cyan;prompt=blue;container=black;greet=cyan;time=lightgreen";
          greeting = "das beste oder nichts.";
        in
        "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland --greeting '${greeting}' --theme '${theme}'";
        user = "greeter";
      };
    };
  };
}
