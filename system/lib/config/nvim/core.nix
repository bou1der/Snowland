_: {
  globals.mapleader = " ";
  viAlias = true;
  vimAlias = false;

  luaLoader.enable = true;
  editorconfig.enable = true;

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 2;
    softtabstop = 2;
    showtabline = 2;
    expandtab = true;
    shiftwidth = 2;
    cursorline = true;
    wrap = false;
  };

  clipboard.providers = {
    wl-copy.enable = true;
  };

}
