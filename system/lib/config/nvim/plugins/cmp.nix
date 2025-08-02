{pkgs, lib, ...}:
{
  plugins = {
    lspkind = {
      enable = true;
      preset = "codicons";
    };
    # cmp-emoji = {
    #   enable = true;
    # };

    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        map_cr = true;
        map_bs = true;
        map_c_h = true;
      };
    };

    cmp = {
      enable = true;
      # extraPlugins = with pkgs.vimPlugins; [
      #     cmp-nvim-lsp
      #     cmp-buffer         
      #     luasnip
      #     cmp_luasnip 
      #   ];
      settings = {
        autoEnableSources = true;
        experimental = {
          ghost_text = true;
        };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        snippet = {
          # expand = "luasnip";
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
          format = lib.mkForce ''
              function(entry, vim_item)
                local lspkind = require("lspkind")
                vim_item.kind = lspkind.presets.default[vim_item.kind] or ""
                vim_item.menu = nil
                return vim_item
              end
            '';
        };
        sources = [
          { name = "git"; }
          { name = "nvim_lsp"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
          {
            name = "path";
            keywordLength = 3;
          }
          {
            name = "luasnip";
            keywordLength = 3;
          }
        ];

        # completion = {
        #   autocomplete = {
        #     "char" = [ "(" ];
        #   };
        # };


        window = {
          completion = {
            border = "rounded";
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None"; # Синхронизация цветов
            col_offset = -3;
            side_padding = 0;
          };
          documentation = {
            border = "rounded";         # Плавные границы для документации
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None";
          };
        };

        mapping = {
          "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        };
      };
    };
    cmp-nvim-lsp = {
      enable = true;
    }; # lsp
    cmp-buffer = {
      enable = true;
    };
    cmp-path = {
      enable = true;
    }; # file system paths
    cmp_luasnip = {
      enable = true;
    }; # snippets
    cmp-cmdline = {
      enable = false;
    }; # autocomplete for cmdline
  };
        #   signature_help = {
        #   enabled = true;
        #   trigger = { char = "(" }; # Показывать сигнатуры при открытии скобки
        # };

  extraConfigLua = ''
        luasnip = require("luasnip")
        kind_icons = {
          Text = "󰊄",
          Method = " ",
          Function = "󰡱 ",
          Constructor = " ",
          Field = " ",
          Variable = "󱀍 ",
          Class = " ",
          Interface = " ",
          Module = "󰕳 ",
          Property = " ",
          Unit = " ",
          Value = " ",
          Enum = " ",
          Keyword = " ",
          Snippet = " ",
          Color = " ",
          File = "",
          Reference = " ",
          Folder = " ",
          EnumMember = " ",
          Constant = " ",
          Struct = " ",
          Event = " ",
          Operator = " ",
          TypeParameter = " ",
        } 

         local cmp = require'cmp'

     -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )


		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})

    -- Set configuration for specific filetype.
     cmp.setup.filetype('gitcommit', {
       sources = cmp.config.sources({
         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
       }, {
         { name = 'buffer' },
       })
     })
  '';
}
