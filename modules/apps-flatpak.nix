{ ... }:

{
  # Nécessite d'ajouter cet input dans flake.nix :
  #
  #   nix-flatpak.url = "github:gmodena/nix-flatpak";
  #
  # Le module nix-flatpak devra être importé par le futur flake. Il rend
  # disponibles les options "remotes" et "packages" ci-dessous.

  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  # Liste déclarative des Flatpaks installés automatiquement à chaque rebuild
  services.flatpak.packages = [
    "org.mozilla.firefox"                 # Firefox
    "org.keepassxc.KeePassXC"             # Gestionnaire de mots de passe
    "io.github.totoshko88.RustConn"       # Gestionnaire de connexions distantes
    "io.github.kolunmi.Bazaar"            # Logithèque Flatpak
    "com.github.tchx84.Flatseal"          # Gestion des permissions Flatpak
    "com.heroicgameslauncher.hgl"         # Heroic Games Launcher
    "com.visualstudio.code"               # Visual Studio Code
    "org.mozilla.Thunderbird"              # Thunderbird
    "org.filezillaproject.Filezilla"      # FileZilla
  ];
}
