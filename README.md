# NixOS · Hyprland · DankMaterialShell

Configuration NixOS personnelle, pensée pour servir de socle commun à plusieurs
machines. Le dépôt rassemble l'environnement graphique **Hyprland**,
**DankMaterialShell (DMS)**, les applications système et une sélection
d'applications Flatpak.

Les fichiers propres à une machine — matériel, chargeur de démarrage, nom
d'hôte, utilisateur, mot de passe et `system.stateVersion` — restent dans le
`configuration.nix` créé par l'installateur NixOS. Ils ne sont donc pas
versionnés ici.

## Organisation

```text
modules/
├── default.nix              # Point d'entrée : importe tous les modules
├── apps-*.nix               # Applications et polices
├── desktop-*.nix            # Hyprland, DMS et écran de connexion
├── gaming-graphics.nix      # Modèles de configuration graphique pour le jeu
├── networking.nix           # Réseau et pare-feu
└── system.nix               # Services et entretien du système
```

Importer le dossier `modules` suffit : NixOS charge automatiquement son
fichier `default.nix`.

## Installation rapide (script automatisé)

```bash
curl -sSL https://raw.githubusercontent.com/DavidBrigand/nixos-dms/main/install.sh | bash
```

*(Ou en clonant manuellement le dépôt et en exécutant `./install.sh` depuis `/etc/nixos/nixos-dms`)*.

## Installation manuelle pas à pas

> **Flatpaks :** `apps-flatpak.nix` active automatiquement le support de Flatpak dans NixOS, ajoute le dépôt Flathub et installe l'application `easyflatpak` via un service systemd lors de chaque déploiement.

## Modules

| Fichier | Rôle |
| --- | --- |
| `modules/default.nix` | Liste centralisée des modules importés par le dépôt. |
| `modules/apps-core.nix` | Applications NixOS communes : Nautilus, Kitty, utilitaires Wayland, GVFS et montage de disques. |
| `modules/apps-flatpak.nix` | Active le support Flatpak, ajoute le dépôt Flathub et installe l'application `easyflatpak`. |
| `modules/apps-fonts.nix` | Polices Noto, Inter, JetBrains Mono Nerd Font et symboles Material. |
| `modules/apps-gaming.nix` | Applications et outils pour le jeu (Steam, Lutris, etc.). |
| `modules/desktop-hyprland.nix` | Hyprland, XWayland, portails XDG et variables Wayland. |
| `modules/desktop-dms.nix` | DMS depuis `nixpkgs-unstable` et ses fonctionnalités. |
| `modules/desktop-greetd.nix` | Écran de connexion DMS avec Hyprland et clavier français. |
| `modules/gaming-graphics.nix` | Blocs commentés pour les configurations jeu NVIDIA seule, AMD ou Intel. |
| `modules/imprimante.nix` | Configuration des services d'impression et pilotes. |
| `modules/networking.nix` | NetworkManager et pare-feu. Le nom d'hôte reste dans le `configuration.nix` de la machine. |
| `modules/system.nix` | PipeWire, Polkit, RTKit, nettoyage automatique du store Nix et activation future des flakes. |

## À venir

- Ajouter un `flake.nix` et un `flake.lock` pour verrouiller les versions de
  `nixpkgs-unstable` et `nix-flatpak`.
- Remplacer le channel `unstable` par une dépendance déclarative.
- Synchroniser le dépôt avec GitHub.
