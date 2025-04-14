{
  inputs,
  pkgs,
  host,
  ...
}:
{
  home.packages = (
    with pkgs;
    [
      multiviewer-for-f1
      netflix
    ]
  );
}
