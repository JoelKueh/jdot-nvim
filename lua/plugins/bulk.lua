local setup = require('setup.bulk')

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
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("sonokai")
		end
	},
	{
		"catppuccin/nvim",
		event = "VeryLazy"
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
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		-- init is called during startup. Configuration for vim plugins typically should be set in an init function
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},

	-- if some code requires a module from an unloaded plugin, it will be automatically loaded.
	-- So for api plugins like devicons, we can always set lazy=true
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	-- you can use the VeryLazy event for things that can
	-- load later and are not important for the initial UI
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

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

