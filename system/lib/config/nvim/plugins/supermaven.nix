{lib, ...}:

{
  plugins.supermaven = {
    enable = true;
    autoLoad = true;

    settings = {
      keymaps = {
        accept_suggestion = "<S-Del>";
        clear_suggestions = "<C-]>";
        accept_word = "<C-j>";
      };

      # color = {
      #   suggestion_color = "#ffffff";
      #   cterm = 244;
      # };

      log_level = "info";
      disable_inline_completion = false;
      disable_keymaps = false;

      # condition = lib.nixvim.mkRaw ''
      #   function()
      #     return false
      #   end
      # '';
    };

  };
}
