local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = require("catppuccin.palettes").get_palette("mocha")
require("heirline").load_colors(colors)

local left = {
	{ provider = "" },
}

local right = {
	{ provider = "" },
}

local ViMode = {
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	static = {
		mode_names = { -- change the strings if you like it vvvvverbose!
			n = "N",
			no = "N?",
			nov = "N?",
			noV = "N?",
			["no\22"] = "N?",
			niI = "Ni",
			niR = "Nr",
			niV = "Nv",
			nt = "Nt",
			v = "V",
			vs = "Vs",
			V = "V_",
			Vs = "Vs",
			["\22"] = "^V",
			["\22s"] = "^V",
			s = "S",
			S = "S_",
			["\19"] = "^S",
			i = "I",
			ic = "Ic",
			ix = "Ix",
			R = "R",
			Rc = "Rc",
			Rx = "Rx",
			Rv = "Rv",
			Rvc = "Rv",
			Rvx = "Rv",
			c = "C",
			cv = "Ex",
			r = "...",
			rm = "M",
			["r?"] = "?",
			["!"] = "!",
			t = "T",
		},
		mode_colors = {
			n = "red",
			i = "blue",
			v = "mauve",
			V = "mauve",
			["\22"] = "mauve",
			c = "yellow",
			s = "mauve",
			S = "mauve",
			["\19"] = "mauve",
			R = "peach",
			r = "peach",
			["!"] = "red",
			t = "red",
		},
	},
	{
		provider = "",
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = self.mode_colors[mode], bold = false, italic = false }
		end,
		update = {
			"ModeChanged",
			pattern = "*:*",
			callback = vim.schedule_wrap(function()
				vim.cmd("redrawstatus")
			end),
		},
	},
}

local FileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}

local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		return { fg = self.icon_color }
	end,
}

local FileIconBuf = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (self.icon .. " ")
	end,
	hl = function(self)
		if self.is_active then
			return { fg = self.icon_color }
		else
			return { fg = "subtext0" }
		end
	end,
}

local FileName = {
	init = function(self)
		self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
		if self.lfilename == "" then
			self.lfilename = "[No Name]"
		end
	end,
	hl = { fg = "mantle" },

	flexible = 1,

	{
		provider = function(self)
			return self.lfilename
		end,
	},
	{
		provider = function(self)
			return vim.fn.pathshorten(self.lfilename)
		end,
	},
}

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			return { bold = true, force = true }
		end
	end,
}

FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local FileEncoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
		return enc .. " "
	end,
	hl = { fg = "mantle" },
}

local Ruler = {
	{ provider = "%02l:%02c", hl = { fg = "mantle", bg = "lavender" } },
}

local Navic = {
	condition = function()
		return require("nvim-navic").is_available()
	end,
	static = {
		type_hl = {
			File = "Directory",
			Module = "@include",
			Namespace = "@namespace",
			Package = "@include",
			Class = "@structure",
			Method = "@method",
			Property = "@property",
			Field = "@field",
			Constructor = "@constructor",
			Enum = "@field",
			Interface = "@type",
			Function = "@function",
			Variable = "@variable",
			Constant = "@constant",
			String = "@string",
			Number = "@number",
			Boolean = "@boolean",
			Array = "@field",
			Object = "@type",
			Key = "@keyword",
			Null = "@comment",
			EnumMember = "@field",
			Struct = "@structure",
			Event = "@keyword",
			Operator = "@operator",
			TypeParameter = "@type",
		},
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end,
	},
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
		local children = {}
		for i, d in ipairs(data) do
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),

					on_click = {
						minwid = pos,
						callback = function(_, minwid)
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = "text" },
				})
			end
			table.insert(children, child)
		end
		self.child = self:new(children, 1)
	end,
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = "text", bg = "base", italic = true },
	update = {
		"CursorMoved",
	},
}

local function nv(provider)
	local data = require("nvim-navic").get_data() or {}
	if #data ~= 0 then
		return provider
	end
end

Navic = {
	condition = nv,
	hl = { fg = "base", bg = "NONE" },
	{
		hl = { bg = "base" },
		provider = " ",
	},
	Navic,
	{
		hl = { bg = "base" },
		provider = " ",
	},
	{
		provider = "",
	},
}

local Diagnostics = {

	condition = conditions.has_diagnostics,

	static = {
		error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
		warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
		info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
		hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
	},

	init = function(self)
		self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
		self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
		self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
	end,

	update = { "DiagnosticChanged", "BufEnter" },

	{
		provider = "",
		hl = { fg = "surface1", bg = "NONE" },
	},
	{
		hl = { bg = "surface1" },
		{ provider = " " },
		{
			provider = function(self)
				-- 0 is just another output, we can decide to print it or not!
				return self.errors > 0 and (self.error_icon .. self.errors .. " ")
			end,
			hl = { fg = "red" },
		},
		{
			provider = function(self)
				return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
			end,
			hl = { fg = "yellow" },
		},
		{
			provider = function(self)
				return self.info > 0 and (self.info_icon .. self.info .. " ")
			end,
			hl = { fg = "sky" },
		},
		{
			provider = function(self)
				return self.hints > 0 and (self.hint_icon .. self.hints)
			end,
			hl = { fg = "teal" },
		},
		{
			provider = " ",
		},
	},
}

local Git = {
	condition = conditions.is_git_repo,

	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
	end,

	hl = { fg = "text" },

	{ -- git branch name
		provider = function(self)
			return "  " .. self.status_dict.head .. " "
		end,
	},
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = " ",
		hl = { fg = "text", bold = true },
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "green" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "red" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "yellow" },
	},
	{
		condition = function(self)
			return self.has_changes
		end,
	},
	{
		provider = function()
			return ""
		end,
		hl = { fg = "overlay0", bg = "NONE" },
	},
}

local TablineFileName = {
	provider = function(self)
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = "_󰷥 ",
		hl = { fg = "teal" },
	},
	{
		condition = function(self)
			return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
				or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
		end,
		provider = function(self)
			if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
				return "  "
			else
				return " "
			end
		end,
		hl = { fg = "peach" },
	},
}

local TablinePicker = {
	condition = function(self)
		return self._show_picker
	end,
	init = function(self)
		local bufname = vim.api.nvim_buf_get_name(self.bufnr)
		bufname = vim.fn.fnamemodify(bufname, ":t")
		local label = bufname:sub(1, 1)
		local i = 2
		while self._picker_labels[label] do
			if i > #bufname then
				break
			end
			label = bufname:sub(i, i)
			i = i + 1
		end
		self._picker_labels[label] = self.bufnr
		self.label = label
	end,
	provider = function(self)
		return self.label
	end,
	hl = { fg = "red", bold = true },
}

vim.keymap.set("n", "gbp", function()
	local tabline = require("heirline").tabline
	local buflist = tabline._buflist[1]
	buflist._picker_labels = {}
	buflist._show_picker = true
	vim.cmd.redrawtabline()
	local char = vim.fn.getcharstr()
	local bufnr = buflist._picker_labels[char]
	if bufnr then
		vim.api.nvim_win_set_buf(0, bufnr)
	end
	buflist._show_picker = false
	vim.cmd.redrawtabline()
end)

local TablineFileNameBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(self.bufnr)
	end,
	on_click = {
		callback = function(_, minwid, _, button)
			if button == "m" then -- close on mouse middle click
				vim.schedule(function()
					vim.api.nvim_buf_delete(minwid, { force = false })
				end)
			else
				vim.api.nvim_win_set_buf(0, minwid)
			end
		end,
		minwid = function(self)
			return self.bufnr
		end,
		name = "heirline_tabline_buffer_callback",
	},
	TablinePicker,
	FileIconBuf,
	TablineFileName,
	TablineFileFlags,
}

local TablineCloseButton = {
	condition = function(self)
		return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
	end,
	{ provider = " " },
	{
		provider = "󰅖",
		on_click = {
			callback = function(_, minwid)
				vim.schedule(function()
					-- vim.api.nvim_buf_delete(minwid, { force = false })
					vim.cmd.BufDel()
					vim.cmd.redrawtabline()
				end)
			end,
			minwid = function(self)
				return self.bufnr
			end,
			name = "heirline_tabline_close_buffer_callback",
		},
	},
}

local TablineBufferBlock = {
	{
		provider = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			local idlist = {}
			local i = 1
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
				idlist[bufferInfo.bufnr] = i
				i = i + 1
			end
			if self.bufnr == nrlist[1] then
				return " "
			elseif self.is_active then
				return " "
			elseif nrlist[idlist[self.bufnr] - 1] == vim.fn.bufnr("%") then
				return " "
			else
				return "|"
			end
		end,
		hl = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
			end
			if self.bufnr == nrlist[1] then
				if self.is_active then
					return { fg = "mauve", bg = "NONE" }
				else
					return { fg = "subtext0", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "mauve", bg = "surface0" }
			else
				return { fg = "subtext0", bg = "surface0" }
			end
		end,
	},
	{
		provider = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			local idlist = {}
			local i = 1
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
				idlist[bufferInfo.bufnr] = i
				i = i + 1
			end
			if self.bufnr == nrlist[1] then
				return ""
			elseif self.is_active then
				return ""
			elseif nrlist[idlist[self.bufnr] - 1] == vim.fn.bufnr("%") then
				return " "
			else
				return " "
			end
		end,
		hl = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
			end
			if self.bufnr == nrlist[1] then
				if self.is_active then
					return { fg = "mauve", bg = "NONE" }
				else
					return { fg = "surface0", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "mauve", bg = "surface0" }
			else
				return { fg = "mantle", bg = "surface0" }
			end
		end,
	},
	{
		TablineFileNameBlock,
		hl = function(self)
			if self.is_active then
				return { fg = "mantle", bg = "mauve" }
			else
				return { fg = "subtext0", bg = "surface0" }
			end
		end,
	},
	{
		TablineCloseButton,
		hl = function(self)
			if self.is_active then
				return { fg = "mantle", bg = "mauve" }
			else
				return { fg = "subtext0", bg = "surface0" }
			end
		end,
	},
	{
		provider = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
			end
			if self.bufnr == nrlist[#nrlist] then
				return ""
			elseif self.is_active then
				return ""
			else
				return " "
			end
		end,
		hl = function(self)
			local bufferInfoList = vim.fn.getbufinfo({ buflisted = true })
			local nrlist = {}
			for _, bufferInfo in ipairs(bufferInfoList) do
				table.insert(nrlist, bufferInfo.bufnr)
			end
			if self.bufnr == nrlist[#nrlist] then
				if self.is_active then
					return { fg = "mauve", bg = "NONE" }
				else
					return { fg = "surface0", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "mauve", bg = "surface0" }
			else
				return { fg = "mantle", bg = "surface0" }
			end
		end,
	},
}

local BufferLine = {
	utils.make_buflist({
		TablineBufferBlock,
	}, { provider = " ", hl = { fg = "surface0" } }, { provider = " ", hl = { fg = "surface0" } }),
}

local Tabpage = {
	provider = function(self)
		return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
	end,
	hl = function(self)
		if not self.is_active then
			return "pink"
		else
			return "TabLineSel"
		end
	end,
}

local TabpageClose = {
	provider = "%999X 󰅖 %X",
	hl = "TabLine",
}

local TabPages = {
	condition = function()
		return #vim.api.nvim_list_tabpages() >= 2
	end,
	utils.make_tablist(Tabpage),
	TabpageClose,
	{ provider = "%=" },
}

local TabLineOffset = {
	condition = function(self)
		local win = vim.api.nvim_tabpage_list_wins(0)[1]
		local bufnr = vim.api.nvim_win_get_buf(win)
		self.winid = win

		if vim.bo[bufnr].filetype == "NvimTree" then
			self.title = "NvimTree"
			return true
		elseif vim.bo[bufnr].filetype == "dapui_watches" then
			self.title = "debug"
			return true
		elseif vim.bo[bufnr].filetype == "aerial" then
			self.title = "aerial"
			return true
		end
	end,

	{
		provider = function(self)
			local title = self.title
			local width = vim.api.nvim_win_get_width(self.winid)
			local pad = math.ceil((width - #title) / 2) - 2
			return string.rep(" ", pad)
		end,
	},
	{
		provider = "",
		hl = { fg = "mauve", bold = true },
	},
	{
		hl = { bg = "mauve", bold = true, italic = true },
		{
			provider = " ",
		},
		{
			provider = function(self)
				return self.title
			end,

			hl = { fg = "mantle", bg = "mauve", bold = true, italic = true },
		},
		{
			provider = " ",
		},
	},
	{
		provider = "",
		hl = { fg = "mauve", bold = true },
	},
	{
		provider = function(self)
			local title = self.title
			local width = vim.api.nvim_win_get_width(self.winid)
			local pad = math.ceil((width - #title) / 2) - 2
			return string.rep(" ", pad)
		end,
	},
}

ViMode = {
	{ provider = " ", hl = { bg = "NONE" } },
	hl = { bg = "surface1" },
	{ provider = " " },
	{ ViMode },
	{ provider = " " },
	{
		provider = "",
		hl = function()
			if conditions.is_git_repo() then
				return { fg = "surface1", bg = "overlay0" }
			else
				return { fg = "surface1", bg = "NONE" }
			end
		end,
	},
}

Git = {
	hl = { bg = "overlay0" },
	Git,
}

Center = {
	hl = { bg = "mauve" },
	{ left, hl = { fg = "mauve", bg = "NONE" } },
	{ provider = " " },
	{ FileNameBlock },
	-- { HelpFileName },
	{ provider = " " },
	{ right, hl = { fg = "mauve", bg = "NONE" } },
}

FileEncoding = {
	{
		provider = "",
		hl = function()
			if conditions.has_diagnostics() then
				return { fg = "maroon", bg = "surface1" }
			else
				return { fg = "maroon", bg = "NONE" }
			end
		end,
	},
	{ provider = " " },
	FileEncoding,
	hl = { bg = "maroon" },
}

Ruler = {
	{
		provider = "",
		hl = { fg = "lavender", bg = "maroon" },
	},
	{ provider = " ", hl = { bg = "lavender" } },
	{ Ruler },
	{ provider = " ", hl = { bg = "lavender" } },
	{ provider = " " },
}

L1 = {
	ViMode,
	Git,
}

C1 = { Center }
C2 = {}

R1 = {
	Diagnostics,
	FileEncoding,
	Ruler,
}

local StatusLine = {
	hl = { italic = true },
	L1,
	{ provider = "%=" },
	{
		flexible = 1,
		C1,
		C2,
	},
	{ provider = "%=" },
	R1,
}

local TabLine = {
	hl = { fg = "NONE", bg = "NONE" },
	{ TabLineOffset },
	{ provider = "%=" },
	{ BufferLine },
	{ provider = "%=" },
	{ TabPages },
}

local WinBar = {
	hl = { bg = "NONE" },
	{ provider = " " },
	{ Navic },
	{ provider = " " },
	{ provider = "%=" },
}

local function useWinbar()
	if vim.g.neovide or vim.g.started_by_firenvim == true then
		return nil
	end
	return WinBar
end
-- require("heirline").load_colors(colors)
require("heirline").setup({
	statusline = StatusLine,
	tabline = TabLine,
	winbar = useWinbar(),
	-- statuscolumn = {},
	opts = {
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = { "nofile", "parompt", "help", "quickfix", "term", "lspsaga" },
				filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "alpha" },
			}, args.buf)
		end,
	},
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
