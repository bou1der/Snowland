-- { "f-person/git-blame.nvim" },
{ 
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    size = 10,
  },
  config = true,
},
{ "j-hui/fidget.nvim" },
{ "stevearc/dressing.nvim" },
{
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_renane = false,
				lsp_doc_border = true,
			},
		})
	end,
},
{
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup()
	end,
},
{
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
	end,
},

