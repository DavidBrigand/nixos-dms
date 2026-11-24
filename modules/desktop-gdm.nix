{ config, pkgs, ... }:

{
  # Désactivation de greetd
  services.greetd.enable = false;

  # Activation de Xserver (nécessaire pour les composants graphiques de base)
  services.xserver.enable = true;

  # Activation du Display Manager de GNOME (nouvelle syntaxe)
  services.displayManager.gdm.enable = true;
}
