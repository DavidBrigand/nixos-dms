{ config, pkgs, ... }:

{
  # Nécessaire pour utiliser une configuration fondée sur les flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Entretien automatique du store Nix pour éviter de saturer le disque.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  # Nécessaire pour PipeWire (son) et les portails Wayland en général
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Polkit requis par Hyprland/DMS pour les demandes d'élévation de droits en graphique
  security.polkit.enable = true;
}
