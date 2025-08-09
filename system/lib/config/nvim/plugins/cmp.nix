{
  plugins = {
    luasnip.enable = true;
    cmp-buffer = { enable = true; };
    cmp-emoji = { enable = true; };
    cmp-nvim-lsp = { enable = true; };
    cmp-path = { enable = true; };
    cmp_luasnip = { enable = true; };

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

      settings = {
        experimental = { ghost_text = true; };
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "nvim_lua"; }
          { name = "path"; }
          { name = "copilot"; }
        ];

        formatting = {
          fields = [ "abbr" "kind" "menu" ];
          format =
            # lua
            ''
              function(_, item)
                local icons = {
                  Namespace = "󰌗",
                  Text = "󰉿",
                  Method = "󰆧",
                  Function = "󰆧",
                  Constructor = "",
                  Field = "󰜢",
                  Variable = "󰀫",
                  Class = "󰠱",
                  Interface = "",
                  Module = "",
                  Property = "󰜢",
                  Unit = "󰑭",
                  Value = "󰎠",
                  Enum = "",
                  Keyword = "󰌋",
                  Snippet = "",
                  Color = "󰏘",
                  File = "󰈚",
                  Reference = "󰈇",
                  Folder = "󰉋",
                  EnumMember = "",
                  Constant = "󰏿",
                  Struct = "󰙅",
                  Event = "",
                  Operator = "󰆕",
                  TypeParameter = "󰊄",
                  Table = "",
                  Object = "󰅩",
                  Tag = "",
                  Array = "[]",
                  Boolean = "",
                  Number = "",
                  Null = "󰟢",
                  String = "󰉿",
                  Calendar = "",
                  Watch = "󰥔",
                  Package = "",
                  Copilot = "",
                  Codeium = "",
                  TabNine = "",
                }

                local icon = icons[item.kind] or ""
                item.kind = string.format("%s %s", icon, item.kind or "")
                return item
              end
            '';
        };

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
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<CR>" =
            # lua
            ''
            cmp.mapping.confirm({
					    behavior = cmp.ConfirmBehavior.Replace,
					    select = true,
				    })
          '';
          "<C-Space>" = "cmp.mapping.complete()";
          "<leader>F" =
            # lua 
            ''
              function(fallback)
                local line = vim.api.nvim_get_current_line()
                if line:match("^%s*$") then
                  fallback()
                elseif cmp.visible() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
                else
                  fallback()
                end
              end
            '';
          "<Down>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").expand_or_jumpable() then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
          "<Up>" =
            # lua
            ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").jumpable(-1) then
                  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                else
                  fallback()
                end
              end
            '';
        };

        extraConfigLua =
          #lua
          ''
             local cmp_autopairs = require('nvim-autopairs.completion.cmp')
               local cmp = require('cmp')
               cmp.event:on(
                 'confirm_done',
                 cmp_autopairs.on_confirm_done()
               )
          '';
      };
    };
  };
}



# {pkgs, lib, ...}:
# {
#   plugins = {
#     cmp-buffer = { enable = true; };
#     cmp-emoji = { enable = true; };
#     cmp-nvim-lsp = { enable = true; };
#     cmp-path = { enable = true; };
#     cmp_luasnip = { enable = true; };
#     cmp-cmdline = {
#       enable = false;
#     };
#
#     lspkind = {
#       enable = true;
#       preset = "codicons";
#     };
#     # cmp-emoji = {
#     #   enable = true;
#     # };
#
#     nvim-autopairs = {
#       enable = true;
#       settings = {
#         check_ts = true;
#         map_cr = true;
#         map_bs = true;
#         map_c_h = true;
#       };
#     };
#
#     cmp = {
#       enable = true;
#       # extraPlugins = with pkgs.vimPlugins; [
#       #     cmp-nvim-lsp
#       #     cmp-buffer         
#       #     luasnip
#       #     cmp_luasnip 
#       #   ];
#       settings = {
#         autoEnableSources = true;
#         experimental = {
#           ghost_text = true;
#         };
#
#         performance = {
#           debounce = 60;
#           fetchingTimeout = 200;
#           maxViewEntries = 30;
#         };
#
#         snippet = {
#           expand = "luasnip";
#           # expand = "function(args) require('luasnip').lsp_expand(args.body) end";
#         };
#
#                 formatting = {
#           fields = [ "abbr" "kind" "menu" ];
#           format =
#             # lua
#             ''
#               function(_, item)
#                 local icons = {
#                   Namespace = "󰌗",
#                   Text = "󰉿",
#                   Method = "󰆧",
#                   Function = "󰆧",
#                   Constructor = "",
#                   Field = "󰜢",
#                   Variable = "󰀫",
#                   Class = "󰠱",
#                   Interface = "",
#                   Module = "",
#                   Property = "󰜢",
#                   Unit = "󰑭",
#                   Value = "󰎠",
#                   Enum = "",
#                   Keyword = "󰌋",
#                   Snippet = "",
#                   Color = "󰏘",
#                   File = "󰈚",
#                   Reference = "󰈇",
#                   Folder = "󰉋",
#                   EnumMember = "",
#                   Constant = "󰏿",
#                   Struct = "󰙅",
#                   Event = "",
#                   Operator = "󰆕",
#                   TypeParameter = "󰊄",
#                   Table = "",
#                   Object = "󰅩",
#                   Tag = "",
#                   Array = "[]",
#                   Boolean = "",
#                   Number = "",
#                   Null = "󰟢",
#                   String = "󰉿",
#                   Calendar = "",
#                   Watch = "󰥔",
#                   Package = "",
#                   Copilot = "",
#                   Codeium = "",
#                   TabNine = "",
#                 }
#
#                 local icon = icons[item.kind] or ""
#                 item.kind = string.format("%s %s", icon, item.kind or "")
#                 return item
#               end
#             '';
#         };
#
#         sources = [
#           { name = "nvim_lsp"; }
#           { name = "luasnip"; }
#           {
#             name = "buffer";
#             option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
#           }
#           { name = "nvim_lua"; }
#           { name = "path"; }
#           { name = "copilot"; }
#         ];
#
#         window = {
#           completion = {
#             winhighlight =
#               "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
#             scrollbar = false;
#             sidePadding = 0;
#             border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
#           };
#
#           settings.documentation = {
#             border = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
#             winhighlight =
#               "FloatBorder:CmpBorder,Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel";
#           };
#         };
#
#         mapping = {
#           "<C-n>" = "cmp.mapping.select_next_item()";
#           "<C-p>" = "cmp.mapping.select_prev_item()";
#           "<C-j>" = "cmp.mapping.select_next_item()";
#           "<C-k>" = "cmp.mapping.select_prev_item()";
#           "<C-d>" = "cmp.mapping.scroll_docs(-4)";
#           "<C-f>" = "cmp.mapping.scroll_docs(4)";
#           "<C-Space>" = "cmp.mapping.complete()";
#           "<S-Tab>" = "cmp.mapping.close()";
#           "<Tab>" =
#             # lua 
#             ''
#               function(fallback)
#                 local line = vim.api.nvim_get_current_line()
#                 if line:match("^%s*$") then
#                   fallback()
#                 elseif cmp.visible() then
#                   cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
#                 else
#                   fallback()
#                 end
#               end
#             '';
#           "<Down>" =
#             # lua
#             ''
#               function(fallback)
#                 if cmp.visible() then
#                   cmp.select_next_item()
#                 elseif require("luasnip").expand_or_jumpable() then
#                   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
#                 else
#                   fallback()
#                 end
#               end
#             '';
#           "<Up>" =
#             # lua
#             ''
#               function(fallback)
#                 if cmp.visible() then
#                   cmp.select_prev_item()
#                 elseif require("luasnip").jumpable(-1) then
#                   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
#                 else
#                   fallback()
#                 end
#               end
#             '';
#         };
#
#         # mapping = {
#         #   "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
#         #   "<Tab>" = "cmp.mapping.select_next_item()";
#         #   "<S-Tab>" = "cmp.mapping.select_prev_item()";
#         #   "<C-e>" = "cmp.mapping.abort()";
#         #   "<C-b>" = "cmp.mapping.scroll_docs(-4)";
#         #   "<C-f>" = "cmp.mapping.scroll_docs(4)";
#         #   # "<S-CR>" = "cmp.mapping.complete()";
#         #   "<S-CR>" = "cmp.mapping.confirm({ select = true })";
#         #   # "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
#         # };
#       };
#     };
#   };
#         #   signature_help = {
#         #   enabled = true;
#         #   trigger = { char = "(" }; # Показывать сигнатуры при открытии скобки
#         # };
#
#   # extraConfigLua = ''
#   #       luasnip = require("luasnip")
#   #       kind_icons = {
#   #         Text = "󰊄",
#   #         Method = " ",
#   #         Function = "󰡱 ",
#   #         Constructor = " ",
#   #         Field = " ",
#   #         Variable = "󱀍 ",
#   #         Class = " ",
#   #         Interface = " ",
#   #         Module = "󰕳 ",
#   #         Property = " ",
#   #         Unit = " ",
#   #         Value = " ",
#   #         Enum = " ",
#   #         Keyword = " ",
#   #         Snippet = " ",
#   #         Color = " ",
#   #         File = "",
#   #         Reference = " ",
#   #         Folder = " ",
#   #         EnumMember = " ",
#   #         Constant = " ",
#   #         Struct = " ",
#   #         Event = " ",
#   #         Operator = " ",
#   #         TypeParameter = " ",
#   #       } 
#   #
#   #        local cmp = require'cmp'
#   #
#   #    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
#   # cmp.setup.cmdline("/", {
#   # 	mapping = cmp.mapping.preset.cmdline(),
#   # 	sources = {
#   # 		{ name = "buffer" },
#   # 	},
#   # })
#   #
#   #   local cmp_autopairs = require('nvim-autopairs.completion.cmp')
#   #     local cmp = require('cmp')
#   #     cmp.event:on(
#   #       'confirm_done',
#   #       cmp_autopairs.on_confirm_done()
#   #     )
#   #
#   #
#   # cmp.setup.cmdline(":", {
#   # 	mapping = cmp.mapping.preset.cmdline(),
#   # 	sources = cmp.config.sources({
#   # 		{ name = "path" },
#   # 	}, {
#   # 		{
#   # 			name = "cmdline",
#   # 			option = {
#   # 				ignore_cmds = { "Man", "!" },
#   # 			},
#   # 		},
#   # 	}),
#   # })
#   #
#   #   -- Set configuration for specific filetype.
#   #    cmp.setup.filetype('gitcommit', {
#   #      sources = cmp.config.sources({
#   #        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
#   #      }, {
#   #        { name = 'buffer' },
#   #      })
#   #    })
#   # '';
# }
