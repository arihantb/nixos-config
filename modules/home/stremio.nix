{
  inputs,
  pkgs,
  host,
  ...
}:
{
  home.packages = (with pkgs; [ stremio ]);
}
