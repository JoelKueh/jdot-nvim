local M = {}

local function setup_clangd()
	local lspconf = require("lspconfig")
	lspconf.clangd.setup({
--		cmd = {
--			'clangd',
--			'--query-driver=/usr/bin/g++',
--			'--query-driver=/opt/microchip/xc16/v2.10/bin/xc16-gcc'
--		},
		filetypes = { "c", "cpp" },
	})
end

local function setup_lua_ls()
	local lspconf = require("lspconfig")
	lspconf.lua_ls.setup({
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if vim.loop.fs_stat(path..'/.luarc.json')
				or vim.loop.fs_stat(path..'/.luarc.jsonc') then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					version = 'LuaJIT'
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
					}
				}
			})
		end,
		settings = {
			Lua = {}
		}
	})
end

local function setup_verible()
	local lspconf = require("lspconfig")
	lspconf.verible.setup({
		cmd = {'verible-verilog-ls', '--rules_config_search'},
		root_dir = function() return vim.loop.cwd() end
	})
end

function M.setup_lsp()
	local lspconf = require("lspconfig")
	local mason = require("mason")
	local masonconf = require("mason-lspconfig")
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

	mason.setup()
	masonconf.setup()

	-- Helpers for complex setups.
	setup_clangd()
	setup_lua_ls()
	setup_verible()

	-- Simple one line setups.
	lspconf.rust_analyzer.setup({})
	lspconf.cmake.setup({})
	lspconf.gdscript.setup(capabilities)
	lspconf.csharp_ls.setup({})
	lspconf.matlab_ls.setup({})
	lspconf.jdtls.setup({})
	lspconf.texlab.setup({})
	--lspconf.omnisharp.setup({})
end

function M.setup_cmp()
	local cmp = require("cmp")

	vim.opt.completeopt = { "menu", "menuone" }

	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.boxy)
			end,
		},
		window = {

		},
		mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<C-y>'] = cmp.mapping.confirm({ select = true }),
		}),
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		}
	})
end

function M.setup_knap()
	local knap = require("knap")

	local function map(mode, l, r, desc)
		vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
	end

	map("n", "<leader>li", knap.process_once, "Knap Process Once")
	map("n", "<leader>lc", knap.close_viewer, "Knap Close")
	map("n", "<leader>ll", knap.toggle_autopreviewing, "Knap Toggle Autopreview")
	map("n", "<leader>lf", knap.forward_jump, "Knap Forward Jump")

	local gknapsettings = {
		htmloutputext = "html",
		htmltohtml = "none",
		htmltohtmlviewerlaunch = "falkon %outputfile%",
		htmltohtmlviewerrefresh = "none",
		mdoutputext = "pdf",
		mdtohtml = "pandoc --standalone %docroot% -o %outputfile%",
		mdtohtmlviewerlaunch = "falkon %outputfile%",
		mdtohtmlviewerrefresh = "none",
		mdtopdf = "pandoc %docroot% -o %outputfile%",
		mdtopdfviewerlaunch = "sioyek %outputfile%",
		mdtopdfviewerrefresh = "none",
		markdownoutputext = "html",
		markdowntohtml = "pandoc --standalone %docroot% -f gfm -o %outputfile%",
		markdowntohtmlviewerlaunch = "falkon %outputfile%",
		markdowntohtmlviewerrefresh = "none",
		markdowntopdf = "pandoc %docroot% -f gfm -o %outputfile%",
		markdowntopdfviewerlaunch = "sioyek %outputfile%",
		markdowntopdfviewerrefresh = "none",
		texoutputext = "pdf",
		textopdf = "pdflatex -interaction=batchmode -halt-on-error -synctex=1 %docroot%",
		textopdfviewerlaunch = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --new-window %outputfile%",
		textopdfviewerrefresh = "none",
		textopdfforwardjump = "sioyek --inverse-search 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%1'\"'\"',%2,%3)\"' --reuse-window --forward-search-file %srcfile% --forward-search-line %line% %outputfile%",
		textopdfshorterror = "A=%outputfile% ; LOGFILE=\"${A%.pdf}.log\" ; rubber-info \"$LOGFILE\" 2>&1 | head -n 1",
		delay = 250
	}
	vim.g.knap_settings = gknapsettings
end

return M
