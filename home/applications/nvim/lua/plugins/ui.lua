return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		event = { "UiEnter", "BufReadPre", "BufAdd", "BufNewFile" },
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "auto", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				float = {
					transparent = true, -- enable transparent floating windows
					solid = true, -- use solid styling for floating windows, see |winborder|
				},
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {
					all = {
						-- overlay0 = "#d77777",
					},
				},
				custom_highlights = {},
				integrations = {
					aerial = true,
					diffview = true,
					illuminate = {
						lsp = true,
					},
					indent_blankline = {
						enabled = true,
						scope_color = "pink",
					},
					lsp_saga = true,
					noice = true,
					navic = {
						enabled = true,
					},
					notify = true,
					nvim_surround = true,
				},
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
			vim.api.nvim_set_hl(0, "MatchParen", { fg = "#333333", bg = "#aadafa", bold = true })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = { "CursorHold", "CursorHoldI" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "▸" },
					topdelete = { text = "▸" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",

					row = 0,
					col = 1,
				},

				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("nvim-navic").setup({
				lsp = {
					auto_attach = true,
				},
				highlight = true,
				icons = {
					File = " ",
					Module = " ",
					Namespace = " ",
					Package = " ",
					Class = " ",
					Method = " ",
					Property = " ",
					Field = " ",
					Constructor = " ",
					Enum = " ",
					Interface = " ",
					Function = " ",
					Variable = " ",
					Constant = " ",
					String = " ",
					Number = " ",
					Boolean = " ",
					Array = " ",
					Object = " ",
					Key = " ",
					Null = " ",
					EnumMember = " ",
					Struct = " ",
					Event = " ",
					Operator = " ",
					TypeParameter = " ",
				},
				depth_limit = 9,
			})
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("nvim-navic", {}),
				callback = function()
					if vim.api.nvim_buf_line_count(0) > 10000 then
						vim.b.navic_lazy_update_context = true
					end
				end,
			})
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		main = "ibl",

		config = function()
			-- vim.api.nvim_set_hl(0, "Green", { fg = "#73D48B" })
			-- vim.api.nvim_set_hl(0, "Blue", { fg = "#61AFEF" })
			require("ibl").setup({
				-- scope = { highlight = { "Green", "Blue" } },
				indent = { char = "▏", tab_char = "▏" },
			})

			-- local hooks = require("ibl.hooks")
			-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, function(_, _, scope, _)
			-- 	if scope:type() == "for_statement" or scope:type() == "if_statement" then
			-- 		return 2
			-- 	end
			-- 	return 1
			-- end)
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({})
		end,
	},
	{
		"b0o/incline.nvim",
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		priority = 1200,
		config = function()
			require("incline").setup({
				window = { margin = { vertical = 0, horizontal = 0 } },
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end
					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					if icon == nil then
						icon = ""
						color = "#6d8086"
					end
					if props.focused then
						return { { icon, guifg = color } }
					end
					return { { icon, guifg = "#666666" } }
				end,
			})
		end,
	},
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("notify").setup({
				fps = 60,
				-- render = "compact",
				stages = "fade",
				max_height = 3,
				timeout = 1,
			})

			local telescope = require("telescope")
			telescope.load_extension("notify")

			vim.keymap.set("n", "<leader>fn", function()
				telescope.extensions.notify.notify()
			end)
		end,
	},
	{
		"folke/noice.nvim",
		enabled = not vim.g.started_by_firenvim,
		lazy = true,
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			views = {
				cmdline_popup = {
					size = {
						width = 30,
					},
				},
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },

		config = function()
			vim.keymap.set("n", "zR", require("ufo").openAllFolds)
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			-- global handler
			-- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
			-- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
			require("ufo").setup({
				fold_virt_text_handler = handler,
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})

			vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#45475a" })
		end,
	},
	{
		"luukvbaal/statuscol.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				bt_ignore = { "terminal", "nofile", "lspsaga" },
				relculright = true,
				foldfunc = "builtin",
				setopt = true,
				segments = {
					{
						sign = {
							name = { "Diagnostic.*" },
							-- maxwidth = 1,
						},
					},
					{
						sign = {
							namespace = { "gitsigns" },
							maxwidth = 1,
							colwidth = 1,
							wrap = true,
						},
					},
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { " " } },
				},
			})
			vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#45475a" })
		end,
	},
	{
		"rebelot/heirline.nvim",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			local heirline = require("plugins.heirline")
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		priority = 1000,
		enabled = true,
		init = false,
		opts = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
                                   __
                               _.-~  )
                    _..--~~~~,'   ,-/     _
                 .-'. . . .'   ,-','    ,' )
               ,'. . . _   ,--~,-'__..-'  ,'
             ,'. . .  (@)' ---~~~~      ,'
            /. . . . '~~             ,-'
           /. . . . .             ,-'
          ; . . . .  - .        ,'
         : . . . .       _     /
        . . . . .          `-.:
       . . . ./  - .          )
      .  . . |  _____..---.._/ _____
~---~~~~----~~~~             ~~]]
			dashboard.section.header.val = vim.split(logo, "\n")

            -- stylua: ignore
            dashboard.section.buttons.val = {
                dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
                dashboard.button("n", " " .. " New file", "<cmd> ene <cr>"),
                dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
                dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
                dashboard.button("s", " " .. " Restore Session", [[<cmd> Persisted load<cr>]]),
                dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
                dashboard.button("u", "󰊳 " .. " Update", "<cmd> Lazy update<cr>"),
                dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
            }
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.section.footer.opts.hl = "AlphaFooter"
			dashboard.opts.layout[1].val = 0
			return dashboard
		end,
		config = function(_, dashboard)
			vim.api.nvim_create_autocmd("User", {
				pattern = "AlphaReady",
				callback = function()
					vim.api.nvim_set_option_value("laststatus", 0, {})
					vim.api.nvim_set_option_value("showtabline", 0, {})
					vim.cmd("Persisted start")
				end,
			})
			vim.api.nvim_create_autocmd("BufUnload", {
				buffer = 0,
				callback = function()
					vim.api.nvim_set_option_value("laststatus", 3, {})
					vim.api.nvim_set_option_value("showtabline", 2, {})
				end,
			})
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					once = true,
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				once = true,
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	{
		"dstein64/nvim-scrollview",
		lazy = true,
		event = { "BufReadPost", "BufAdd", "BufNewFile" },
		config = function()
			require("scrollview").setup({
				excluded_filetypes = { "NvimTree" },
				current_only = true,
				base = "right",
				signs_on_startup = {},
				diagnostics_severities = { vim.diagnostic.severity.ERROR },
				winblend_gui = 50,
				signs_overflow = "right",
			})
			local mauve = require("catppuccin.palettes").get_palette("mocha")["mauve"]
			vim.cmd("highlight ScrollView guibg=" .. mauve)
		end,
	},
}
