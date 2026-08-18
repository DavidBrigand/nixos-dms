{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # compatibilité avec les apps X11
  };

  # Portails XDG nécessaires au partage d'écran, sélecteurs de fichiers natifs, etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Variables d'environnement utiles pour Wayland (Firefox, Electron, Qt/GTK)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";      # apps Electron/Chromium en natif Wayland
    MOZ_ENABLE_WAYLAND = "1";  # Firefox en natif Wayland
    XKB_DEFAULT_LAYOUT = "fr"; # Configuration du clavier en AZERTY par défaut
  };
}
