{config, pkgs, inputs, lib, ... }: {
  
  #Additional Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    times-newer-roman
  ]; 
}