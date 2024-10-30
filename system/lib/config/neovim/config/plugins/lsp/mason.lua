{
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		local mason_lspconfig = require("mason-lspconfig")

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"biome",
				"ts_ls",
				"html",
				"cssls",
				"jsonls",
				"tailwindcss",
        "pyright",
        "clangd",
        "rnix"
			},
		})

		local mason_tool_installer = require("mason-tool-installer")
		mason_tool_installer.setup({
			ensure_installed = {
				"stylua",
				"biome",
				"black",
        "pyright",
				"biome",
        "clangd",
        "rnix"
			},
		})
	end,
},

