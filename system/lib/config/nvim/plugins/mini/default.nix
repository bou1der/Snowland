
{
  imports = [
    ./comment.nix
    ./starter.nix
    # ./fuzzy.nix
    # ./extra.nix
    # ./pick.nix
  ];
  plugins.mini = {
    enable = true;
  };
}
