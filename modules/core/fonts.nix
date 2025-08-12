{ pkgs, ...}:
{
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      fira-mono
      font-awesome
      nerd-fonts.fira-mono
      nerd-fonts.hack
    ];
  };
}
