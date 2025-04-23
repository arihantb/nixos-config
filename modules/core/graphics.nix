/**
  This configuration sets up Nvidia PRIME with offloading for system with hybrid graphics.
*/

{ config, ... }:

let
  # Import GPU bus IDs (intelBusId, nvidiaBusId, amdgpuBusId) from a local Nix file.
  gpuBusIds = import ./gpu-bus-id.nix;
in
{
  hardware = {
    nvidia = {
      # Use kernel mode-setting (KMS) for better multi-monitor support and smoother graphics.
      modesetting.enable = true;

      # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
      # Enable this if you have graphical corruption issues or application crashes after waking up from sleep.
      # This fixes it by saving the entire VRAM memory to /tmp/ instead of just the bare essentials.
      powerManagement.enable = true;

      # Fine-grained power management. Turns off GPU when not in use.
      # Experimental and only works on modern Nvidia GPUs (Turing or newer).
      powerManagement.finegrained = true;

      # Use the NVidia open source kernel module (not to be confused with the independent third-party "nouveau" open source driver).
      # Support is limited to the Turing and later architectures.
      # Full list of supported GPUs is at: https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus.
      # Only available from driver 515.43.04+.
      open = true;

      # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Nvidia Optimus PRIME is a technology developed by Nvidia to optimize the power consumption and performance of laptops equipped with their GPUs.
      # It seamlessly switches between the integrated graphics, usually from Intel, for lightweight tasks to save power, and the discrete Nvidia GPU for performance-intensive tasks like gaming or video editing.
      # By dynamically balancing graphics power and battery life, Optimus provides the best of both worlds, ensuring that users get longer battery life without sacrificing graphical performance.
      prime = {
        offload = {
          # Enable PRIME offloading (use Intel by default, offload apps to Nvidia when needed).
          enable = true;

          # Enable the `__NV_PRIME_RENDER_OFFLOAD=1` command-line switch for offloading.
          enableOffloadCmd = true;
        };

        # Set Intel GPU bus ID (needed for PRIME to know which GPU is the "primary").
        intelBusId = gpuBusIds.intelBusId;

        # Set Nvidia GPU bus ID (needed for offloading and X11 config).
        nvidiaBusId = gpuBusIds.nvidiaBusId;
      };

      # Use the stable version of the Nvidia driver.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  # Tell X11 and Wayland to load the Nvidia driver.
  services.xserver.videoDrivers = [ "nvidia" ];
}
