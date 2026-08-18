{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Gestionnaire de fichiers (Nautilus/GNOME Files) + extensions utiles
    nautilus
    nautilus-open-any-terminal
    file-roller        # gestion des archives (zip, tar...)
    gnome-disk-utility  # équivalent GNOME Disks

    # Terminal (léger, très adapté à Hyprland/Wayland)
    kitty

    # Utilitaires système essentiels
    networkmanagerapplet
    pavucontrol         # contrôle audio graphique
    brightnessctl       # luminosité
    playerctl           # contrôle lecture média
    wl-clipboard        # presse-papier Wayland

    # Divers
    unzip
    git
    adwaita-icon-theme
    xdg-utils
    bibata-cursors
  ];

  # Active le service GVFS pour que Nautilus gère bien les montages, MTP, etc.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
