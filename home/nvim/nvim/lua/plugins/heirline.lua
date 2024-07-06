local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
	black = "#000000",
	white = "#dfdfdf",
	red = "#e44876",
	green = "#73D48B",
	blue = "#5E9BD6",
	purple = "#AF8CC9",
	pink = "#F4A7C6",
	orange = "#E08060",
	navy = "#214165",
	darknavy = "#112135",
	darkgray = "#6E303E",
	lightgray = "#6E6E6E",
	inactivegray = "#2C2E26",
	git = "#394260",
	-- git = "#ff6053",
	add = "#a6e3a1",
	change = "#f9e2af",
	delete = "#f38ba8",
	-- error = "#DB4B4B",
	error = "#f38ba8",
	-- warning = "#fab387",
	warning = "#f9e2af",
	-- info = "#0DB9D7",
	info = "#89dceb",
	-- hint = "#1ABC9D",
	hint = "#94e2d5",
}
require("heirline").load_colors(colors)

local left = {
	{ provider = "" },
}

local right = {
	{ provider = "" },
}

local ViMode = {
	-- get vim current mode, this information will be required by the provider
	-- and the highlight functions, so we compute it only once per component
	-- evaluation and store it as a component attribute
	init = function(self)
		self.mode = vim.fn.mode(1) -- :h mode()
	end,
	-- Now we define some dictionaries to map the output of mode() to the
	-- corresponding string and color. We can put these into `static` to compute
	-- them at initialisation time.
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
			n = "pink",
			i = "blue",
			v = "purple",
			V = "purple",
			["\22"] = "purple",
			c = "green",
			s = "purple",
			S = "purple",
			["\19"] = "purple",
			R = "orange",
			r = "orange",
			["!"] = "red",
			t = "red",
		},
	},
	-- We can now access the value of mode() that, by now, would have been
	-- computed by `init()` and use it to index our strings dictionary.
	-- note how `static` fields become just regular attributes once the
	-- component is instantiated.
	-- To be extra meticulous, we can also add some vim statusline syntax to
	-- control the padding and make sure our string is always at least 2
	-- characters long. Plus a nice Icon.
	{
		provider = function(self)
			if vim.fn["skkeleton#mode"]() == "hira" then
				return "あ"
            elseif vim.fn["skkeleton#mode"]() == "kata" then
				return "ア"
            elseif vim.fn["skkeleton#mode"]() == "hankata" then
				return " ｱ"
            elseif vim.fn["skkeleton#mode"]() == "zenkaku" then
				return "全"
            elseif vim.fn["skkeleton#mode"]() == "abbrev" then
				return "ab"
			else
				return ""
			end
		end,
		-- Same goes for the highlight. Now the foreground will change according to the current mode.
		hl = function(self)
			local mode = self.mode:sub(1, 1) -- get only the first mode character
			return { fg = self.mode_colors[mode], bold = false, italic = false; }
		end,
		-- Re-evaluate the component only on ModeChanged event!
		-- Also allows the statusline to be re-evaluated when entering operator-pending mode
		update = {
			"ModeChanged",
			"User",
		},

	},
}

local FileNameBlock = {
	-- let's first set up some attributes needed by this component and it's children
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
}
-- We can now define some children separately and add them later

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
			return { fg = "#777777" }
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
	hl = { fg = "white" },

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

local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = "_󰷥",
		hl = { fg = "" },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = "orange" },
	},
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

local FileNameModifer = {
	hl = function()
		if vim.bo.modified then
			-- use `force` because we need to override the child's hl foreground
			return { fg = "pink", bold = true, force = true }
		end
	end,
}

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
	FileNameBlock,
	FileIcon,
	utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
	-- FileFlags,
	{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bold = true },
}

local FileEncoding = {
	provider = function()
		local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
		return enc .. " "
	end,
	hl = { fg = "white" },
}

local FileFormat = {
	provider = function()
		local fmt = vim.bo.fileformat
		return fmt ~= "unix" and fmt:upper()
	end,
}

local FileSize = {
	provider = function()
		-- stackoverflow, compute human readable file size
		local suffix = { "b", "k", "M", "G", "T", "P", "E" }
		local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
		fsize = (fsize < 0 and 0) or fsize
		if fsize < 1024 then
			return fsize .. suffix[1]
		end
		local i = math.floor((math.log(fsize) / math.log(1024)))
		return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
	end,
}

-- We're getting minimalists here!
local Ruler = {
	-- %l = current line number
	-- %L = number of lines in the buffer
	-- %c = column number
	-- %P = percentage through file of displayed window
	-- provider = "%7(%l/%3L%):%2c %P",
	{ provider = "%02l:%02c", hl = { fg = "white", bg = "navy" } },
}

local LSPActive = {
	condition = conditions.lsp_attached,
	update = { "LspAttach", "LspDetach" },

	-- You can keep it simple,
	-- provider = " [LSP]",

	-- Or complicate things a bit and get the servers names
	provider = function()
		local names = {}
		for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			table.insert(names, server.name)
		end
		return " [" .. table.concat(names, " ") .. "]"
	end,
	hl = { fg = "green", bold = true },

	on_click = {
		callback = function()
			vim.defer_fn(function()
				vim.cmd("LspInfo")
			end, 100)
		end,
		name = "heirline_LSP",
	},
}

-- Awesome plugin
-- Full nerd (with icon colors and clickable elements)!
-- works in multi window, but does not support flexible components (yet ...)

local Navic = {
	condition = function()
		return require("nvim-navic").is_available()
	end,
	static = {
		-- create a type highlight map
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
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
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
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = "#cccccc" },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = "#cccccc", bg = "inactivegray", italic = true },
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
	hl = { fg = "inactivegray", bg = "NONE" },
	{
		hl = { bg = "inactivegray" },
		provider = " ",
	},
	Navic,
	{
		hl = { bg = "inactivegray" },
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
		hl = { fg = "lightgray", bg = "NONE" },
	},
	{
		hl = { bg = "lightgray" },
		{
			provider = " ",
		},
		{
			provider = function(self)
				-- 0 is just another output, we can decide to print it or not!
				return self.errors > 0 and (self.error_icon .. self.errors .. " ")
			end,
			hl = { fg = "error" },
		},
		{
			provider = function(self)
				return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
			end,
			hl = { fg = "warning" },
		},
		{
			provider = function(self)
				return self.info > 0 and (self.info_icon .. self.info .. " ")
			end,
			hl = { fg = "info" },
		},
		{
			provider = function(self)
				return self.hints > 0 and (self.hint_icon .. self.hints)
			end,
			hl = { fg = "hint" },
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

	hl = { fg = "white" },

	{ -- git branch name
		provider = function(self)
			return "  " .. self.status_dict.head .. " "
		end,
	},
	-- You could handle delimiters, icons and counts similar to Diagnostics
	{
		condition = function(self)
			return self.has_changes
		end,
		provider = " ",
		hl = { fg = "white", bold = true },
	},
	{
		provider = function(self)
			local count = self.status_dict.added or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "add" },
	},
	{
		provider = function(self)
			local count = self.status_dict.removed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "delete" },
	},
	{
		provider = function(self)
			local count = self.status_dict.changed or 0
			return count > 0 and (" " .. count .. " ")
		end,
		hl = { fg = "change" },
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
		hl = { fg = "git", bg = "NONE" },
	},
}

local WorkDir = {
	provider = function()
		local icon = (vim.fn.haslocaldir(0) == 1 and "l" or "g") .. " " .. " "
		local cwd = vim.fn.getcwd(0)
		cwd = vim.fn.fnamemodify(cwd, ":~")
		if not conditions.width_percent_below(#cwd, 0.25) then
			cwd = vim.fn.pathshorten(cwd)
		end
		local trail = cwd:sub(-1) == "/" and "" or "/"
		return icon .. cwd .. trail
	end,
	hl = { fg = "blue", bold = true },
}

local TablineBufnr = {
	provider = function(self)
		return " " .. tostring(self.bufnr) .. "."
	end,
}

-- we redefine the filename component, as we probably only want the tail and not the relative path
local TablineFileName = {
	provider = function(self)
		-- self.filename will be defined later, just keep looking at the example!
		local filename = self.filename
		filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
		return filename
	end,
	hl = function(self)
		return { bold = self.is_active or self.is_visible, italic = true }
	end,
}

-- this looks exactly like the FileFlags component that we saw in
-- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
-- also, we are adding a nice icon for terminal buffers.
local TablineFileFlags = {
	{
		condition = function(self)
			return vim.api.nvim_buf_get_option(self.bufnr, "modified")
		end,
		provider = "_󰷥 ",
		hl = { fg = "red" },
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
		hl = { fg = "orange" },
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

-- Here the filename block finally comes together
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
	-- TablineBufnr,
	TablinePicker, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
	FileIconBuf,
	TablineFileName,
	TablineFileFlags,
}

-- a nice "x" button to close the buffer
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

-- The final touch!
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
					return { fg = "navy", bg = "NONE" }
				else
					return { fg = "darknavy", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "navy", bg = "darknavy" }
			else
				return { fg = "#777777", bg = "darknavy" }
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
					return { fg = "navy", bg = "NONE" }
				else
					return { fg = "darknavy", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "navy", bg = "darknavy" }
			else
				return { fg = "#777777", bg = "darknavy" }
			end
		end,
	},
	{
		TablineFileNameBlock,
		hl = function(self)
			if self.is_active then
				return { fg = "pink", bg = "navy" }
			else
				return { fg = "#777777", bg = "darknavy" }
			end
		end,
	},
	{
		TablineCloseButton,
		hl = function(self)
			if self.is_active then
				return { fg = "white", bg = "navy" }
			else
				return { fg = "#777777", bg = "darknavy" }
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
					return { fg = "navy", bg = "NONE" }
				else
					return { fg = "darknavy", bg = "NONE" }
				end
			elseif self.is_active then
				return { fg = "navy", bg = "darknavy" }
			else
				return { fg = "#777777", bg = "darknavy" }
			end
		end,
	},
}

-- and here we go
local BufferLine = {
	utils.make_buflist(
		{
			TablineBufferBlock,
		},
		{ provider = " ", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
		{ provider = " ", hl = { fg = "gray" } } -- right trunctation, also optional (defaults to ...... yep, ">")
		-- by the way, open a lot of buffers and try clicking them ;)
	),
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
	-- only show this component if there's 2 or more tabpages
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
		hl = { fg = "navy", bold = true },
	},
	{
		hl = { bg = "navy", bold = true, italic = true },
		{
			provider = " ",
		},
		{
			provider = function(self)
				return self.title
			end,

			hl = { fg = "pink", bg = "navy", bold = true, italic = true },
		},
		{
			provider = " ",
		},
	},
	{
		provider = "",
		hl = { fg = "navy", bold = true },
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

local HelpFileName = {
	condition = function()
		return vim.bo.filetype == "help"
	end,
	provider = function()
		local filename = vim.api.nvim_buf_get_name(0)
		return vim.fn.fnamemodify(filename, ":t")
	end,
	hl = { fg = colors.black },
}

local ViMode = {
	{ provider = " ", hl = { bg = "NONE" } },
	hl = { bg = "navy" },
	{ provider = " " },
	{ ViMode },
	{ provider = " " },
	{
		provider = "",
		hl = function()
			if conditions.is_git_repo() then
				return { fg = "navy", bg = "git" }
			else
				return { fg = "navy", bg = "NONE" }
			end
		end,
	},
}

local Git = {
	hl = { bg = "git" },
	Git,
}

local Center = {
	hl = { bg = "navy" },
	{ left, hl = { fg = "navy", bg = "NONE" } },
	{ provider = " " },
	{ FileNameBlock },
	-- { HelpFileName },
	{ provider = " " },
	{ right, hl = { fg = "navy", bg = "NONE" } },
}

local FileEncoding = {
	{
		provider = "",
		hl = function()
			if conditions.has_diagnostics() then
				return { fg = "darkgray", bg = "lightgray" }
			else
				return { fg = "darkgray", bg = "NONE" }
			end
		end,
	},
	{ provider = " " },
	FileEncoding,
	hl = { bg = "darkgray" },
}

local Ruler = {
	{
		provider = "",
		hl = { fg = "navy", bg = "darkgray" },
	},
	{ provider = " ", hl = { bg = "navy" } },
	{ Ruler },
	{ provider = " ", hl = { bg = "navy" } },
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
		-- if the callback returns true, the winbar will be disabled for that window
		-- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
		disable_winbar_cb = function(args)
			return conditions.buffer_matches({
				buftype = { "nofile", "parompt", "help", "quickfix", "term", "lspsaga" },
				filetype = { "^git.*", "fugitive", "Trouble", "dashboard", "alpha" },
			}, args.buf)
		end,
	},
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])
