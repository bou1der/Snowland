
{pkgs, ...}:

{
  home.packages = with pkgs ; [
    speedtest-cli
    inetutils
    sysbench
    hyprshot
    evtest
    ventoy
    pywal
    btop
    nmap
    tree
    tmux
  ];
}
