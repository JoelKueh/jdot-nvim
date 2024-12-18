
local M = {}

function M.setup_treesitter()
	local configs = require("nvim-treesitter.configs")

	configs.setup({
		ensure_installed = {
			"c",
			"lua",
			"luadoc",
			"luap",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"html",
			"markdown",
			"markdown_inline",
			"bash",
			"diff",
			"jsdoc",
			"json",
			"jsonc",
			"printf",
			"python",
			"regex",
			"toml",
			"tsx",
			"typescript",
			"xml",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		textobjects = {
			move = {
				enable = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner"
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner"
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner"
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner"
				},
			},
		},
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

function M.setup_telescope()
	local telescope = require("telescope")
	local builtin = require("telescope.builtin")

	telescope.load_extension("undo")

	-- File pickers
	vim.keymap.set("n", '<leader>pf', builtin.find_files, {
		desc="Fuzzy find files"
	})
	vim.keymap.set("n", '<leader>ps', builtin.live_grep, {
		desc="Fuzzy live grep"
	})
	vim.keymap.set("n", '<leader>pb', builtin.buffers, {
		desc="Fuzzy open buffers"
	})

	-- Lsp pickers
	vim.keymap.set("n", '<leader>pe', builtin.diagnostics, {
		desc="Fuzzy lsp diagnostics"
	})
	vim.keymap.set("n", '<leader>pr', builtin.lsp_references, {
		desc="Fuzzy lsp references"
	})
	vim.keymap.set("n", '<leader>pi', builtin.lsp_incoming_calls, {
		desc="Fuzzy lsp incoming"
	})
	vim.keymap.set("n", '<leader>po', builtin.lsp_outgoing_calls, {
		desc="Fuzzy lsp outgoing"
	})
	vim.keymap.set("n", '<leader>pyd', builtin.lsp_document_symbols, {
		desc="Fuzzy document symbols"
	})
	vim.keymap.set("n", '<leader>pyw', builtin.lsp_workspace_symbols, {
		desc="Fuzzy document symbols"
	})

	-- Utility pickers
	vim.keymap.set("n", '<leader>pc', builtin.colorscheme, {
		desc="Fuzzy colorscheme"
	})
	vim.keymap.set("n", '<leader>pu', '<cmd>Telescope undo<cr>', {
		desc="Fuzzy undotree"
	})
	vim.keymap.set("n", '<leader>pt', '<cmd>TodoTelescope<cr>', {
		desc="Fuzzy todo"
	})

	-- Git pickers
	vim.keymap.set("n", '<leader>gf', builtin.git_files, {
		desc="Fuzzy git files"
	})
	vim.keymap.set("n", '<leader>gc', builtin.git_commits, {
		desc="Fuzzy git commits"
	})
	vim.keymap.set("n", '<leader>gs', builtin.git_stash, {
		desc="Fuzzy git stashes"
	})
	vim.keymap.set("n", '<leader>gb', builtin.git_branches, {
		desc="Fuzzy git branches"
	})
	vim.keymap.set("n", '<leader>gt', builtin.git_status, {
		desc="Fuzzy git status"
	})
end

function M.setup_persistence()
	require('persistence').setup({})

	-- restore the session for the current directory
	vim.api.nvim_set_keymap("n", "<leader>qs",
		[[<cmd>lua require("persistence").load()<cr>]], {
		desc = "Restore directory session"
	})
	-- restore the last session
	vim.api.nvim_set_keymap("n", "<leader>ql",
		[[<cmd>lua require("persistence").load({ last = true })<cr>]], {
		desc = "Restore last session"
	})
end

function M.attach_gitsigns(buffer)
	local gs = package.loaded.gitsigns

	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
	end

	-- stylua: ignore start
	map("n", "]h", function()
		if vim.wo.diff then
			vim.cmd.normal({ "]c", bang = true })
		else
			gs.nav_hunk("next")
		end
	end, "Next Hunk")
	map("n", "[h", function()
		if vim.wo.diff then
			vim.cmd.normal({ "[c", bang = true })
		else
			gs.nav_hunk("prev")
		end
	end, "Prev Hunk")
	map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
	map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
	map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
	map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
	map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
	map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
	map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
	map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
	map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
	map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
	map("n", "<leader>ghd", gs.diffthis, "Diff This")
	map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
	map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
end

return M
