{ config, pkgs, ... }:

let
  gpuBusIds = import ./gpu-bus-id.nix;
in
{
  # Enable OpenGL
  hardware = {
    graphics = {
      enable = true;
    };
    nvidia = {
      # Modesetting is required
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking
      # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
      # of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures. Full list of 
      # supported GPUs is at: 
      # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
      # Only available from driver 515.43.04+
      open = true;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Nvidia Optimus PRIME is a technology developed by Nvidia to optimize the power consumption
      # and performance of laptops equipped with their GPUs. It seamlessly switches between the
      # integrated graphics, usually from Intel, for lightweight tasks to save power, and the
      # discrete Nvidia GPU for performance-intensive tasks like gaming or video editing.
      # By dynamically balancing graphics power and battery life, Optimus provides the best of both
      # worlds, ensuring that users get longer battery life without sacrificing graphical performance.
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = gpuBusIds.intelBusId;
        nvidiaBusId = gpuBusIds.nvidiaBusId;
      };

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
}
