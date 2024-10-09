
{pkgs, ...}:

{
  home.packages = with pkgs ; [
    inetutils
    sysbench
    hyprshot
    ventoy
    pywal
    btop
    nmap
    tree
    tmux
  ];
}
