/**
  This configuration sets up both a zram-based swap and a disk-based swapfile.
*/

{ ... }:
{
  swapDevices = [
    {
      # Path to the regular swap file.
      device = "/var/swap/swapfile";

      # Size of the swap file (32GB).
      size = 32 * 1024;

      # Lower priority than zram.
      # Used when zram is full or under pressure.
      priority = 10;
    }
  ];

  zramSwap = {
    # A compressed block device in RAM for swap (faster than disk-based swap).
    enable = true;

    # Zram data compression algorithm.
    algorithm = "zstd";

    # Higher priority than regular swapfile - used first when swapping begins.
    priority = 100;
  };
}
