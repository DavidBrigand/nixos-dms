{ config, lib, pkgs, ... }:

{
  # Base commune : accélération graphique (OpenGL / Vulkan) et bibliothèques 32 bits (nécessaire pour Steam/Proton)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Activation de GameMode pour optimiser automatiquement les performances du CPU/GPU en jeu
  programs.gamemode.enable = true;
}