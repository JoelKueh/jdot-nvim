local setup = require('setup.file')

return {
	-- nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = setup.setup_treesitter
	},
	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'debugloop/telescope-undo.nvim',
		},
		config = setup.setup_telescope
	},
	-- persistence
	{
		"folke/persistence.nvim",
		config = setup.setup_persistence
	},
	-- gitsigns
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = setup.attach_gitsigns,
		}
	},
	-- git-messenger
	{
		'rhysd/git-messenger.vim',
		event = "BufEnter"
	},
	-- todo-comments
	{
		'folke/todo-comments.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {

		}
	}
}
