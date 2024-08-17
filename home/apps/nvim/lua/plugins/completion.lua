return {
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		keys = {
			{ ":", mode = "n" },
			{ "/", mode = "n" },
			{ "?", mode = "n" },
		},
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
			},
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"lukas-reineke/cmp-under-comparator",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			-- "kdheepak/cmp-latex-symbols",
			"ray-x/cmp-treesitter",
			"onsails/lspkind.nvim",
			"zbirenbaum/copilot-cmp",
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")
			require("copilot_cmp").setup()
			local map = cmp.mapping

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				preselect = cmp.PreselectMode.Item,
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				mapping = {
					["<C-d>"] = map.scroll_docs(-4),
					["<C-f>"] = map.scroll_docs(4),
					["<C-a>"] = map.complete(),
					["<C-e>"] = map.abort(),
					["<CR>"] = map.confirm({ select = false }),
					["<tab>"] = map(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
							-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
							-- they way you will only jump inside the snippet region
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-tab>"] = map(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "copilot" },
					{
						name = "lazydev",
						group_index = 0,
					},
				}),
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						scrollbar = false,
					}),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = lspkind.cmp_format({
						mode = "symbol",
						preset = "codicons",
						symbol_map = { Copilot = "" },
						max_width = 50,
						ellipsis_char = "...",
						show_labelDetails = false,
						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},
				performance = {
					debounce = 1,
					throttle = 1,
					async_budget = 1,
					max_view_entries = 120,
				},
			})
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				completion = { completeopt = "menu,menuone,noselect" },
				sources = cmp.config.sources({
					{
						name = "buffer",
						option = {
							keyword_pattern = [[\k\+]],
						},
					},
				}),
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				completion = { completeopt = "menu,menuone,noinsert,noselect" },
				sources = cmp.config.sources({
					{ name = "path" },
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#70E0FF" })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				filetypes = { markdown = true },
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		event = "InsertEnter",
		run = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load({})
			local ls = require("luasnip")
			local snip = ls.snippet
			local text = ls.text_node
			local insert = ls.insert_node

			ls.add_snippets(nil, {
				cpp = {
					snip({
						trig = "std",
					}, {
						text({ "#include <bits/stdc++.h>", "using namespace std;", "" }),
						insert(0),
					}),
				},
			})
		end,
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
}
