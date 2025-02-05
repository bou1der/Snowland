{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvidia-container-toolkit
    libnvidia-container
    speedtest-cli
    nodejs_22
    neofetch
    pciutils
    openssl
    openssh
    btop
    jdk
    git
    tmux
    bun
  ];

  environment.variables = {
    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
    PATH = "/home/boulder/.bun/bin:$PATH";
  };

}
