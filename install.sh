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
  sudo python3 -c '
path = "/etc/nixos/configuration.nix"
with open(path, "r") as f:
    content = f.read()

import re
# Cherche imports = [ ... ] et ajoute ./nixos-dms/modules dedans
if "./nixos-dms/modules" not in content:
    new_content = re.sub(r"(imports\s*=\s*\[)", r"\1\n    ./nixos-dms/modules,", content, count=1)
    if new_content == content:
        # Fallback si format différent
        new_content = content.replace("imports = [", "imports = [\n    ./nixos-dms/modules,")
    with open(path, "w") as f:
        f.write(new_content)
'
fi

echo "=== 3. Ajout du canal unstable (pour DMS) ==="
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nix-channel --update

echo "=== 4. Application de la configuration NixOS ==="
sudo nixos-rebuild switch

echo "=== Terminé ! ==="
echo "Pensez à lancer 'dms setup' dans votre session Hyprland après la première connexion."
