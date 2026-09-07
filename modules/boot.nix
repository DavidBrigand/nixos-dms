{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
    };

    # Charger les modules NVIDIA tôt dans l'initrd (Early KMS)
    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 5;
  };

  # Délai pour plymouth avec driver nvidia
  boot.initrd.systemd.services.plymouth-start = {
    after = [ "systemd-modules-load.service" ];
    requires = [ "systemd-modules-load.service" ];
  };
}
