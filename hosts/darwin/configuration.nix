{lib, config, inputs, ... }: 
let
  darwinmodulesPath = ../../modules/darwin;
  darwin-config-files = lib.filesystem.listFilesRecursive darwinmodulesPath;
in
{
  system.stateVersion = 7;
  imports = builtins.filter (file: lib.hasSuffix ".nix" file) darwin-config-files;

  # Define Hostname
  networking.hostName = lib.removeSuffix "\n" (builtins.readFile ../../hostname/darwin);
}
