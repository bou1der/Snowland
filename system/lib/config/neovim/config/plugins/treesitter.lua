{
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			modules = {},
			ensure_installed = {
				"lua",
				"python",
				"typescript",
				"typescript",
        "nix",
				"tsx",
				"css",
				"html",
				"vim",
				"dockerfile",
        "cpp",
				"gitignore",
				"vimdoc",
				"markdown",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = { "javascript" },

			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "python" },
			},
		})
	end,
},
