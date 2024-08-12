return {
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "<C-m>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<Leader>lr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<Leader>ll", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<Leader>fm", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
			require("lspconfig.ui.windows").default_options.border = "rounded"

			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, ls in pairs({}) do
				lspconfig.ls.setup({
					capabilities = capabilities,
				})
			end
			lspconfig.nil_ls.setup({
				capabilities = capabilities,
				settings = {
					["nil"] = {
						formatting = {
							command = { "nixfmt" },
						},
					},
				},
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							pathStrict = true,
							path = { "?.lua", "?/init.lua" },
						},
						workspace = {
							checkThirdParty = "Disable",
							library = {
								vim.env.VIMRUNTIME,
							},
						},
						format = {
							enable = false,
						},
					},
				},
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
				},
				init_options = {
					clangdFileStatus = true,
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.completion.spell,
					-- null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" } }),
				},
			})
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					sign = false,
				},
			})
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
			vim.keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>")
			vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
			vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
			vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>")
			vim.keymap.set("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")
			vim.keymap.set("n", "<Leader>ee", "<cmd>Lspsaga show_line_diagnostics ++unfocus<CR>")
			vim.keymap.set("n", "<Leader>eb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
			vim.keymap.set("n", "<Leader>ew", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
			vim.keymap.set("n", "<Leader>fi", "<cmd>Lspsaga incoming_calls<CR>")
			vim.keymap.set("n", "<Leader>fo", "<cmd>Lspsaga outgoing_calls<CR>")
			vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
			vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
			vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "VeryLazy",
		dependencies = {},
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "󰝥", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointCondition",
				{ text = "󰟃", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
			vim.api.nvim_set_keymap(
				"n",
				"<F8>",
				[[:lua require"dap".toggle_breakpoint()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<F9>",
				[[:lua require"dap".continue()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<F10>",
				[[:lua require"dap".step_over()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<S-F10>",
				[[:lua require"dap".step_into()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<F12>",
				[[:lua require"dap.ui.widgets".hover()<CR>]],
				{ noremap = true, silent = true }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<F5>",
				[[:lua require"osv".launch({port = 8086})<CR>]],
				{ noremap = true, silent = true }
			)
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		keys = {
			{ "<leader>d", mode = "n" },
		},
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>d", ':lua require("dapui").toggle()<CR>', { silent = true })
			require("dapui").setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},

				expand_lines = true,
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 30,
						position = "left",
					},

					{
						elements = {
							"repl",
						},
						size = 0.20,
						position = "bottom",
					},
				},

				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "",
						play = "",
						runlast = "↻",
						step_back = "",
						step_into = "󰆹",
						step_out = "󰆸",
						step_over = "󰆷",
						stopped = "",
						terminate = "󰝤",
					},
				},

				floating = {
					max_height = nil,
					max_width = nil,
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},

				windows = { indent = 1 },
				render = {
					max_type_length = nil,
					max_value_lines = 100,
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		lazy = true,
		keys = {
			{ "<leader>m", mode = "n" },
		},
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreviewToggle<CR>")
		end,
	},
}
