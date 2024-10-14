
{pkgs, ...}:

{
  home.packages = with pkgs ; [
    speedtest-cli
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
