{ config, pkgs, ... }:

let
  flatpakPackages = [
    "org.mozilla.firefox"                 # Firefox
    "org.keepassxc.KeePassXC"             # Gestionnaire de mots de passe
    "io.github.totoshko88.RustConn"       # Gestionnaire de connexions distantes
    "io.github.kolunmi.Bazaar"            # Logithèque Flatpak
    "com.github.tchx84.Flatseal"          # Gestion des permissions Flatpak
    "com.heroicgameslauncher.hgl"         # Heroic Games Launcher
    "com.visualstudio.code"               # Visual Studio Code
    "org.mozilla.Thunderbird"             # Thunderbird
    "org.filezillaproject.Filezilla"      # FileZilla
  ];

  flatpakInstallScript = pkgs.writeShellScript "install-flatpaks" ''
    # S'assurer que la commande flatpak est disponible
    if ! command -v flatpak &> /dev/null; then
      exit 0
    fi

    # Ajouter le dépôt Flathub s'il n'existe pas
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

    # Installer chaque paquet s'il n'est pas déjà présent
    for pkg in ${toString flatpakPackages}; do
      flatpak install -y flathub "$pkg"
    done
  '';
in
{
  services.flatpak.enable = true;

  # Script d'activation pour installer automatiquement les Flatpaks au switch/rebuild de NixOS
  system.activationScripts.install-flatpaks = {
    text = ''
      ${flatpakInstallScript}
    '';
  };
}
