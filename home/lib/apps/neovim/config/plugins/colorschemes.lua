	{
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			dim_inactive_windows = false,
			extend_background_behind_borders = true,
			enable = {
				terminal = true,
				legacy_highlights = true,
			},
			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},
		})
		vim.cmd("colorscheme rose-pine")
	end,
},
