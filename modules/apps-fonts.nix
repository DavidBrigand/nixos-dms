{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    inter                 # police par défaut agréable pour DMS
    nerd-fonts.jetbrains-mono # icônes + glyphes pour terminal/barre DMS
    material-symbols
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Inter" ];
    monospace = [ "JetBrainsMono Nerd Font" ];
  };
}
