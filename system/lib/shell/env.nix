{ pkgs, ... }:

{
  home.packages = with pkgs ; [

    (python312.withPackages (env: with env;[
      pip
      pipx
      virtualenv
    ]))
    vscode-extensions.biomejs.biome
    luajitPackages.luarocks
    typescript
    gnumake42
    nodejs_22
    xdg-utils
    libinput
    ripgrep
    redis
    cmake
    unzip
    btop
    zip
    bun
  ];


  home = {
    sessionVariables = {
      BROWSER = "firefox";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";

      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";

      TERMINAL = "kitty";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
  };
}
