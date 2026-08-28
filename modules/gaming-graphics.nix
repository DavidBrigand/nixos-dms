{ config, lib, pkgs, ... }:

{
  # Ce module est importé mais n'active rien par défaut.
  # Décommente uniquement le bloc correspondant à la carte graphique du poste.

  # Base commune au jeu : accélération graphique et bibliothèques 32 bits.
   hardware.graphics = {
     enable = true;
     enable32Bit = true;
   };
   programs.gamemode.enable = true;

  # NVIDIA — PC fixe avec une seule carte NVIDIA.
  # Nécessite les paquets non libres : décommente aussi la ligne allowUnfree.
  # nixpkgs.config.allowUnfree = true;
   services.xserver.videoDrivers = [ "nvidia" ];
   hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
          # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Suite passage en 26.05 plus de multi screen donc force le pilote en legacy pour tests
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    #package = config.boot.kernelPackages.nvidiaPackages.production;
   };

  # AMD — carte Radeon ou circuit graphique AMD intégré.
  # Les pilotes Mesa/RADV sont sélectionnés automatiquement.
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };

  # Intel — circuit graphique Intel intégré.
  # hardware.graphics = {
  #   enable = true;
  #   enable32Bit = true;
  # };

  # NVIDIA hybride (portable avec iGPU + NVIDIA) : volontairement non inclus.
  # Cette configuration nécessite les identifiants PCI propres à chaque machine.
}
