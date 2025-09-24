local setup = require('setup.bulk')

return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	-- which-key
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gs"] = { name = "+surround" },
				--["z"] = { name = "+fold" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				--["<leader><tab>"] = { name = "+tabs" },
				--["<leader>b"] = { name = "+buffer" },
				--["<leader>c"] = { name = "+code" },
				["<leader>p"] = { name = "+pick/find" },
				["<leader>py"] = { name = "+pick/symbols" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks", ["_"] = "which_key_ignore" },
				--["<leader>q"] = { name = "+quit/session" },
				--["<leader>s"] = { name = "+search" },
				--["<leader>u"] = { name = "+ui" },
				--["<leader>w"] = { name = "+windows" },
				--["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		}
	},
	-- lualine
	{
		'nvim-lualine/lualine.nvim',
		opts = setup.opts_lualine
	},
	-- dashboard-nvim
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = setup.setup_dashboard,
		dependencies = { {'nvim-tree/nvim-web-devicons'}}
	},
	-- icon-picker
	{
		"ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({ disable_legacy_commands = true })
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<Leader>ii", "<cmd>IconPickerNormal<cr>", opts)
			vim.keymap.set("n", "<Leader>iy", "<cmd>IconPickerYank<cr>", opts)
			vim.keymap.set("n", "<Leader>ip", "<cmd>IconPickerInsert<cr>", opts)
		end
	}
}

