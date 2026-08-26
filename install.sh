#!/usr/bin/env bash
set -e

echo "=== 1. Récupération du dépôt NixOS DMS ==="
if [ ! -d "/etc/nixos/nixos-dms" ]; then
  sudo nix-shell -p git --run "sudo git clone https://github.com/DavidBrigand/nixos-dms.git /etc/nixos/nixos-dms"
else
  echo "Le dossier /etc/nixos/nixos-dms existe déjà. Mise à jour via nix-shell..."
  sudo nix-shell -p git --run "sudo git -C /etc/nixos/nixos-dms pull"
fi

echo "=== 2. Vérification / Ajout de l'import dans configuration.nix ==="
CONFIG_FILE="/etc/nixos/configuration.nix"
if sudo grep -q "./nixos-dms/modules" "$CONFIG_FILE"; then
  echo "L'import de nixos-dms est déjà présent dans $CONFIG_FILE."
else
  echo "Ajout de l'import de nixos-dms dans $CONFIG_FILE..."
  # Utilisation d'un utilitaire standard POSIX/GNU (awk) au lieu de Python ou de sed complexe
  sudo awk '
    /imports = \[/ {
      print
      print "    ./nixos-dms/modules,"
      next
    }
    { print }
  ' "$CONFIG_FILE" | sudo tee "${CONFIG_FILE}.tmp" > /dev/null
  sudo mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
fi

echo "=== 3. Ajout du canal unstable (pour DMS) ==="
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --update

echo "=== 4. Application de la configuration NixOS ==="
sudo nixos-rebuild switch

echo "=== Terminé ! ==="
echo "Pensez à lancer 'dms setup' dans votre session Hyprland après la première connexion."
