return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason-lspconfig.nvim",
			"nvimtools/none-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
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
			require("mason").setup({
				ui = {
					check_outdated_packages_on_open = false,
					border = "rounded",
				},
			})
			require("lspconfig.ui.windows").default_options.border = "rounded"

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								workspace = {
									checkThirdParty = false,
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
				["clangd"] = function()
					local cmp_nvim_lsp = require("cmp_nvim_lsp")
					require("lspconfig").clangd.setup({
						capabilities = cmp_nvim_lsp.default_capabilities(),
						cmd = {
							"clangd",
							"--offset-encoding=utf-16",
						},
						init_options = {
							clangdFileStatus = true,
						},
					})
				end,
			})
			require("mason-null-ls").setup({
				handlers = {},
				diagnostics_format = "#{m} (#{s}: #{c})",
			})
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.completion.spell,
					-- null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" } }),
				},
			})
			require("mason-nvim-dap").setup({
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
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
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		config = function()
			vim.keymap.set("n", "<leader>m", "<cmd>MarkdownPreviewToggle<CR>")
		end,
	},
}
