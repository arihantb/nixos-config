/**
  This configuration sets up Powerlevel10k Zsh prompt theme.
*/

{ ... }:
{
  # Symlink the local '.p10k.zsh' file to '~/.p10k.zsh'.
  home.file.".p10k.zsh".source = ./.p10k.zsh;
}
