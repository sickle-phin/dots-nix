return {
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"typescript",
					"javascript",
					"rust",
					"python",
					"go",
					"lua",
					"bash",
					"html",
					"css",
					"vue",
					"vim",
					"yaml",
					"toml",
					"ini",
					"json",
					"dockerfile",
					"markdown",
					"markdown_inline",
					"diff",
					"gitignore",
					"nix",
					"regex",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "grn",
						scope_incremental = "grc",
						node_decremental = "grm",
					},
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{
		"olimorris/persisted.nvim",
		lazy = true,
		event = "VimEnter",
		config = function()
			require("persisted").setup({
				use_git_branch = true, -- create session files based on the branch of a git enabled repository
				default_branch = "main", -- the branch to load if a session file is not found for the current branch
				autostart = false, -- automatically save session files when exiting Neovim
				should_save = function()
					-- do not autosave if the alpha dashboard is the current filetype
					if vim.bo.filetype == "alpha" then
						return false
					end
					return true
				end,
				autoload = false, -- automatically load the session for the cwd on Neovim startup
				on_autoload_no_session = function()
					vim.notify("No existing session to load.")
				end,
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		lazy = true,
		keys = {
			{ "/", mode = "n" },
			{ "?", mode = "n" },
		},
		event = "VeryLazy",
		config = function()
			require("hlslens").setup()

			vim.keymap.set({ "n", "x" }, "<Leader>L", function()
				vim.schedule(function()
					if require("hlslens").exportLastSearchToQuickfix() then
						vim.cmd("cw")
					end
				end)
				return ":noh<CR>"
			end, { expr = true })
			vim.opt.shortmess:append("S")
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("Comment").setup()
			vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {})
			vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})
		end,
	},
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"mvllow/modes.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			require("modes").setup({
				colors = {
					copy = "#f5c359",
					delete = "#c75c6a",
					insert = "#5e9bd6",
					visual = "#af8cc9",
				},

				-- Set opacity for cursorline and number background
				line_opacity = 0.55,

				-- Enable cursor highlights
				set_cursor = true,

				-- Enable cursorline initially, and disable cursorline for inactive windows
				-- or ignored filetypes
				set_cursorline = true,

				-- Enable line number highlights to match cursorline
				set_number = true,

				-- Disable modes highlights in specified filetypes
				-- Please PR commonly ignored filetypes
				ignore_filetypes = { "NvimTree", "TelescopePrompt" },
			})
		end,
	},
	{
		"RRethy/vim-illuminate",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			require("illuminate").configure({
				-- providers: provider used to get references in the buffer, ordered by priority
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
				-- delay: delay in milliseconds
				delay = 100,
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
	},
	{
		"ojroques/nvim-bufdel",
		lazy = true,
		cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
		config = function()
			require("bufdel").setup({
				next = "tabs",
				quit = true, -- quit Neovim when last buffer is closed
			})
		end,
	},
	{
		"smoka7/hop.nvim",
		keys = {
			{ "t", mode = "n" },
		},
		config = function()
			-- place this in one of your configuration file(s)
			require("hop").setup()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "t", function()
				hop.hint_char1({ current_line_only = false })
			end, { remap = true })
		end,
	},
	{
		"max397574/better-escape.nvim",
		commit = "7e86edafb8c7e73699e0320f225464a298b96d12",
		lazy = true,
		event = "VeryLazy",
		config = function()
			-- lua, default settings
			require("better_escape").setup({
				mapping = { "jj" }, -- a table with mappings to use
				timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
				clear_empty_lines = false, -- clear line after escaping if there is only whitespace
				-- keys = "<Esc>",             -- keys used for escaping, if it is a function will use the result everytime
				-- example(recommended)
				keys = function()
					return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>"
				end,
			})
		end,
	},
}
