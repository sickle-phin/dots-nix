return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter").install({
				"bash",
				"c",
				"cpp",
				"css",
				"csv",
				"diff",
				"dockerfile",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"go",
				"html",
				"ini",
				"javascript",
				"json",
				"lua",
				"make",
				"markdown",
				"markdown_inline",
				"nix",
				"php",
				"php_only",
				"python",
				"qmljs",
				"regex",
				"rust",
				"toml",
				"typescript",
				"vim",
				"vue",
				"yaml",
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
				callback = function(ctx)
					pcall(vim.treesitter.start)
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					if ctx.match ~= "nix" then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					else
						vim.bo.indentexpr = ""
					end
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		init = function()
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v", -- charwise
						["@function.outer"] = "V", -- linewise
						-- ['@class.outer'] = '<c-v>', -- blockwise
					},
					include_surrounding_whitespace = false,
				},
			})

			-- keymaps
			vim.keymap.set({ "x", "o" }, "am", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "im", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals")
			end)
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
			local theme = require("base46").current_theme
			local colors = require("base46").theme_tables[theme].base_30
			require("modes").setup({
				colors = {
					copy = colors.yellow,
					delete = colors.red,
					insert = colors.blue,
					visual = colors.purple,
				},
				line_opacity = 0.55,
				set_cursor = true,
				set_cursorline = false,
				set_number = true,
                set_signcolumn = true,
				ignore = { "NvimTree", "TelescopePrompt" },
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
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				mappings = {
					v = {
						j = {
							k = false,
						},
					},
				},
			})
			if vim.fn.executable("fcitx5-remote") == 1 then
				vim.g.fcitx_state = 0
				local grp = vim.api.nvim_create_augroup("fcitx5_manage", { clear = true })

				vim.api.nvim_create_autocmd("InsertLeave", {
					group = grp,
					callback = function()
						vim.g.fcitx_state = tonumber(vim.fn.system("fcitx5-remote")) or 0
						vim.fn.system("fcitx5-remote -c")
					end,
				})

				vim.api.nvim_create_autocmd("InsertEnter", {
					group = grp,
					callback = function()
						if vim.g.fcitx_state == 2 then
							vim.fn.system("fcitx5-remote -o")
						end
					end,
				})
			end
		end,
	},
}
