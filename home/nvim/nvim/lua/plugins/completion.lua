local sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
    { name = "copilot" },
}

local skk_sources = {
    { name = "skkeleton" },
    { name = "path" },
}

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
			"rinx/cmp-skkeleton",
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
					completeopt = "menu,menuone,noinsert",
				},
				mapping = {
					["<C-d>"] = map.scroll_docs(-4),
					["<C-f>"] = map.scroll_docs(4),
					["<C-a>"] = map.complete(),
					["<C-e>"] = map.abort(),
					["<CR>"] = map.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
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
				}),

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
				}),
				sources = sources,
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

			vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#70E0FF" })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			local function nodePath()
				if vim.fn.has("win32") == 1 then
					return "C:\\Program Files\\nodejs\\node.exe"
				else
					return "/etc/profiles/per-user/sickle-phin/bin/node"
				end
			end
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				copilot_node_command = nodePath(),
			})
		end,
	},
	{
		"vim-skk/skkeleton",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile", "VeryLazy" },
		dependencies = {
			"vim-denops/denops.vim",
			"delphinus/skkeleton_indicator.nvim",
		},
		config = function()
			-- 辞書を探す
			local function dictPath()
				if vim.fn.has("win32") == 1 then
					return "dir " .. os.getenv("HOMEPATH") .. "\\skk"
				else
					return "ls /usr/share/skk/*"
				end
			end
			local dictionaries = {}
			local handle = io.popen(dictPath()) -- フルバスで取得
			if handle then
				for file in handle:lines() do
					table.insert(dictionaries, file)
				end
				table.insert(dictionaries, "/usr/share/skk-emoji-jisyo-ja/SKK-JISYO.emoji-ja.utf8")
				handle:close()
			end
			vim.api.nvim_create_autocmd("User", {
				pattern = "skkeleton-initialize-pre",
				callback = function()
					vim.fn["skkeleton#config"]({
						eggLikeNewline = true,
						registerConvertResult = true,
						globalDictionaries = dictionaries,
						showCandidatesCount = 0,
					})
					vim.fn["skkeleton#register_kanatable"]("rom", {
						jj = "escape",
					})
				end,
			})
			vim.fn["skkeleton#initialize"]()
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorEiji", { fg = "#88c0d0", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorHira", { fg = "#89b4fa", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorKata", { fg = "#89b4fa", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorHankata", { fg = "#89b4fa", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorZenkaku", { fg = "#89b4fa", bg = "NONE", bold = true })
			vim.api.nvim_set_hl(0, "SkkeletonIndicatorAbbrev", { fg = "#89b4fa", bg = "NONE", bold = true })
			require("skkeleton_indicator").setup({
				border = "rounded",
				alwaysShown = false,
			})
			local function enable_autocomplete()
				local cmp = require("cmp")
				cmp.setup({
					completion = {
						completeopt = "menu,menuone,noinsert",
					},
					sources = sources,
				})
			end
			local function disable_autocomplete()
				local cmp = require("cmp")
				cmp.setup({
					completion = {
						completeopt = "menu,menuone,noinsert,noselect",
					},
					sources = skk_sources,
				})
			end

			vim.api.nvim_create_user_command("NvimCmpEnable", enable_autocomplete, {})
			vim.api.nvim_create_user_command("NvimCmpDisable", disable_autocomplete, {})
			vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-enable)")
			vim.api.nvim_create_autocmd("User", {
				pattern = "skkeleton-enable-pre",
				callback = function()
					vim.cmd("NvimCmpDisable")
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				pattern = "skkeleton-disable-pre",
				callback = function()
					vim.cmd("NvimCmpEnable")
				end,
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		--tag = "v1.*",
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
