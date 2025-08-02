{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
				javascript = [ "biome" ];
				typescript = [ "biome" ];
				javascriptreact = [ "biome" ];
				typescriptreact = [ "biome" ];
				svelte = [ "biome" ];
				css = [ "prettier" ];
				html = [ "biome" ];
				json = [ "biome" ];
				yaml = [ "biome" ];
				markdown = [ "biome" ];
				graphql = [ "biome" ];
				liquid = [ "biome" ];
				lua = [ "stylua" ];
				python = [ "isort" "black" ];
      };
      format_on_save ={

				lsp_fallback = true;
				async = false;
				timeout_ms = 1000;
      };
    };
  };
}
