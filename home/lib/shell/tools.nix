
{pkgs, ...}:

{
  home.packages = with pkgs ; [
    wireguard-tools
    clang-tools
    alacritty
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
