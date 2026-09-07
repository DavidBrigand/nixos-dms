{ config, lib, pkgs, ... }:

{
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

    # Charger les modules NVIDIA tôt dans l'initrd (Early KMS)
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
}
