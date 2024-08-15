return {
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		keys = {
			{ "<C-f>", mode = "n" },
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.api.nvim_create_user_command("Ex", function()
				vim.cmd.NvimTreeToggle()
			end, {})
			vim.keymap.set("n", "<C-f>", vim.cmd.NvimTreeToggle)
			require("nvim-tree").setup({
				sort_by = "extension",

				view = {
					width = "20%",
					side = "left",
					signcolumn = "no",
				},

				renderer = {
					highlight_git = true,
					highlight_opened_files = "name",
					icons = {
						glyphs = {
							git = {
								unstaged = "!",
								renamed = "»",
								untracked = "?",
								deleted = "✘",
								staged = "✓",
								unmerged = "",
								ignored = "◌",
							},
						},
					},
				},

				actions = {
					expand_all = {
						max_folder_discovery = 100,
						exclude = { ".git", "target", "build" },
					},
				},

				on_attach = require("plugins.nvim-tree-actions").on_attach,
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},

		config = function()
			local telescope = require("telescope")

			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					layout_config = {
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<esc>"] = require("telescope.actions").close,
						},
					},
					-- winblend = 30,
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					file_browser = {
						hidden = { file_browser = true, folder_browser = true },
						follow_symlinks = true,
					},
				},
			})

			local themes = require("telescope.themes")
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep)
			vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags)
			vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
			vim.keymap.set("n", "<leader>fc", builtin.commands)
			vim.keymap.set("n", "<leader>ft", builtin.treesitter)
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = true,
		cmd = "DiffviewOpen",
	},
	{
		"stevearc/aerial.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("aerial").setup({
				-- optionally use on_attach to set keymaps when aerial has attached to a buffer
				on_attach = function(bufnr)
					-- Jump forwards/backwards with '{' and '}'
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				layout = {
					default_direction = "float",
				},
				float = {
					relative = "win",
					override = function(conf, source_winid) -- <- the source_winid is new
						local padding = 1
						conf.anchor = "NE"
						conf.row = padding
						conf.col = vim.api.nvim_win_get_width(source_winid) - padding
						return conf
					end,
				},
				disable_max_lines = 10000,
				disable_max_size = 2000000,
			})
			-- You probably also want to set a keymap to toggle aerial
			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
		end,
	},
	{
		"glacambre/firenvim",
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		lazy = not vim.g.started_by_firenvim,
		build = function()
			vim.fn["firenvim#install"](0)
		end,
		config = function()
			vim.g.firenvim_config = {
				localSettings = {
					[".*"] = {
						takeover = "never",
						cmdline = "firenvim",
					},
				},
			}
		end,
	},
}
