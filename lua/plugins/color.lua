
return {
	-- the colorscheme should be available when starting Neovim
	{
		"gbprod/nord.nvim",
		event = "VeryLazy",
		config = function()
			require("nord").setup({
				transparent = true
			})
		end
	},
	{
		"neanias/everforest-nvim",
		event = "VeryLazy"
	},
	{
		"sainnhe/sonokai",
		event = "VeryLazy"
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end
	},
	{
		"Mofiqul/vscode.nvim",
		event = "VeryLazy"
	},
	{
		"sainnhe/gruvbox-material",
		event = "VeryLazy"
	},
	{
		"fneu/breezy",
		event = "VeryLazy"
	},
	{
		"folke/tokyonight.nvim",
		event = "VeryLazy"
	}
}
