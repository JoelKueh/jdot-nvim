local lsp = require('setup.lsp')

return {
	-- LuaSnip
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		lazy = true,
		dependencies = {
			'saadparwaiz1/cmp_luasnip'
		}
	},
	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-omni"
		},
		config = lsp.setup_cmp
	},
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile", "VeryLazy" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"L3MON4D3/LuaSnip",
		},
		config = lsp.setup_lsp
	},
	-- knap
	{
		"frabjous/knap",
		lazy = false,
		config = lsp.setup_knap
	}
}
