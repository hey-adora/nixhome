vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

require("catppuccin").setup({
	flavour = "frappe",
})
vim.cmd.colorscheme("catppuccin")

local telescope = require("telescope").setup({})
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", function()
	telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

require("nvim-treesitter.configs").setup({
	ensure_installed = {},
	sync_install = false,
	auto_install = false,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	incremental_selection = {
		enable = true,
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({
	capabilities = capabilities,
})
lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
})

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.nixfmt,
	},
})
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})

vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").load()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

			-- For `mini.snippets` users:
			-- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
			-- insert({ body = args.body }) -- Insert at cursor
			-- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
			-- require("cmp.config").set_onetime({ sources = {} })
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-l>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		-- { name = 'vsnip' }, -- For vsnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = "buffer" },
	}),
})

-- require("lsp-progress").setup()
--
-- local function LspStatus()
-- 	return require("lsp-progress").progress({
-- 		format = function(messages)
-- 			return #messages > 0 and table.concat(messages, " ") or ""
-- 		end,
-- 	})
-- end

require("lualine").setup({
	options = {
		component_separators = { left = "|", right = "|" },
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = {
			"diagnostics",
			{ "branch", icons_enabled = false },
		},
		lualine_c = {
			"filename",
			{
				"lsp_status",
				icon = "", -- f013
				symbols = {
					-- Standard unicode symbols to cycle through for LSP progress:
					spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
					-- Standard unicode symbol for when LSP is done:
					done = "✓",
					-- Delimiter inserted between LSP names:
					separator = " ",
				},
				-- List of LSP names to ignore (e.g., `null-ls`):
				ignore_lsp = {},
			},
			-- function()
			-- 	return require("lsp-progress").progress()
			-- end,
			-- function()
			-- 	return require("lsp-progress").progress({
			-- 		format = function(messages)
			-- 			print(messages)
			-- 			return #messages
			-- 			-- return #messages > 0 and table.concat(messages, " ") or ""
			-- 		end,
			-- 	})
			-- end,
		},
	},
	tabline = {
		lualine_a = {
			"buffers",
		},
	},
})

vim.diagnostic.config({
	-- update_in_insert = true,
    virtual_text = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})
vim.keymap.set("n", "cx", function()
    vim.diagnostic.open_float()
end)

local trouble = require("trouble")
trouble.setup({})
-- trouble.

vim.keymap.set("n", "<leader>xx", function()
	vim.cmd([[ Trouble diagnostics toggle ]])
end)
vim.keymap.set("n", "<leader>xj", function()
	vim.cmd([[ Trouble diagnostics next ]])
end)
vim.keymap.set("n", "<leader>xk", function()
	vim.cmd([[ Trouble diagnostics prev ]])
end)

-- vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
-- vim.api.nvim_create_autocmd("User", {
-- 	group = "lualine_augroup",
-- 	pattern = "LspProgressStatusUpdated",
-- 	callback = require("lualine").refresh,
-- })
