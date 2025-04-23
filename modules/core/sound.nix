/**
  This configuration sets up modern audio support using PipeWire instead of the older PulseAudio or JACK.
*/

{ pkgs, ... }:
{
  services = {
    # Explicitly disable the legacy PulseAudio service.
    pulseaudio.enable = false;

    pipewire = {
      # Enable PipeWire - a modern audio and video server meant to replace PulseAudio and JACK.
      enable = true;

      alsa = {
        # Enable ALSA (Advanced Linux Sound Architecture) support through PipeWire.
        enable = true;

        # Enable 32-bit ALSA support (needed for running 32-bit apps/games with sound).
        support32Bit = true;
      };

      # Provide a PulseAudio compatibility layer (so apps using PulseAudio APIs still work).
      pulse.enable = true;

      # [Optional]: Uncomment the following to enable low-latency tuning (good for audio production/live use).
      # lowLatency.enable = true;
    };
  };

  # Preserve ALSA mixer levels across reboots.
  hardware.alsa.enablePersistence = true;

  environment.systemPackages = with pkgs; [
    # Adds full PulseAudio utilities (CLI tools like `pactl`, `paplay`) for interacting with PipeWire's Pulse emulation.
    pulseaudioFull
  ];
}
