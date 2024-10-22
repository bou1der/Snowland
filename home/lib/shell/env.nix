{pkgs, ...}:
{
  home.packages = with pkgs ; [

    (python312.withPackages (env : with env;[
      pip
      pipx
      virtualenv
    ]))
    vscode-extensions.biomejs.biome
    luajitPackages.luarocks
    # nodePackages.prettier
    typescript
    gnumake42
	  nodejs_22
    xdg-utils
    ripgrep
    redis
    cmake
	  unzip
	  zip
    bun
  ];



  home = {
    sessionVariables = {
      browser = "firefox";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      TERMINAL = "kitty";
      BROWSER = "firefox";
    };
  };
}
