if vim.loader then
	vim.loader.enable()
end
vim.api.nvim_set_var("loaded_netrw", 1)
vim.api.nvim_set_var("loaded_netrwPlugin", 1)

-- encoding
vim.api.nvim_set_option_value("encoding", "utf-8", {})
vim.api.nvim_set_option_value("scriptencoding", "utf-8", {})

-- visual

-- 24bit RGB color
vim.api.nvim_set_option_value("termguicolors", true, {})

-- scroll from 4 lines back
vim.api.nvim_set_option_value("scrolloff", 4, {})
-- if contains upper case, search by perfect matching
vim.api.nvim_set_option_value("ignorecase", true, {})
vim.api.nvim_set_option_value("smartcase", true, {})

-- replace with preview
vim.api.nvim_set_option_value("inccommand", "split", {})

-- use clipboard
vim.api.nvim_set_option_value("clipboard", "unnamedplus", {})

-- show line number
vim.api.nvim_set_option_value("number", true, {})

-- highlight cursor line
vim.api.nvim_set_option_value("cursorline", true, {})

vim.api.nvim_set_option_value("signcolumn", "yes:1", {})

-- vim.api.nvim_win_set_option(0, "wrap", false)

-- Number of spaces that a <Tab>
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = "*",
-- 	group = vim.api.nvim_create_augroup("buffer_set_options", {}),
-- 	callback = function()
-- 		vim.api.nvim_set_option_value(0, "tabstop", 4)
-- 		vim.api.nvim_set_option_value(0, "shiftwidth", 0)
-- 		vim.api.nvim_set_option_value(0, "expandtab", true)
-- 	end,
-- })

vim.api.nvim_set_option_value("expandtab", true, {})
vim.api.nvim_set_option_value("tabstop", 4, {})
vim.api.nvim_set_option_value("softtabstop", 4, {})
vim.api.nvim_set_option_value("shiftwidth", 0, {})
vim.api.nvim_set_option_value("smartindent", true, {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		if vim.g.started_by_firenvim == true then
			vim.api.nvim_set_option_value("showtabline", 0, {})
		elseif vim.bo[0].filetype ~= "alpha" then
		 	vim.api.nvim_set_option_value("laststatus", 3, {})
		 	vim.api.nvim_set_option_value("showtabline", 2, {})
		end
	end,
})

vim.api.nvim_set_option_value("pumheight", 12, {})
vim.api.nvim_set_option_value("pumblend", 0, {})
vim.api.nvim_set_option_value("winblend", 0, {})

vim.api.nvim_set_option_value("visualbell", true, {})
vim.api.nvim_set_option_value("showmatch", true, {})
vim.api.nvim_set_option_value("matchtime", 1, {})

-- search
vim.api.nvim_set_option_value("incsearch", true, {})

--vim.o.hlsearch = true
vim.keymap.set("n", "<Esc><Esc>", ":nohl<CR>", { noremap = true, silent = true })

vim.api.nvim_set_option_value("undofile", true, {})
vim.api.nvim_set_option_value("undodir", vim.fn.stdpath("cache") .. "/undo", {})

-- manipulation
vim.g.mapleader = " "

vim.api.nvim_set_option_value("ttimeout", true, {})
vim.api.nvim_set_option_value("ttimeoutlen", 50, {})
vim.api.nvim_set_option_value("timeout", true, {})
vim.api.nvim_set_option_value("timeoutlen", 600, {})

vim.api.nvim_set_option_value("updatetime", 200, {})

vim.api.nvim_set_option_value("ambwidth", "double", {})

-- UFO folding
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.opt.listchars = {tab='▏ ', trail='￮', extends='»', precedes='«', nbsp='⏑'}
vim.opt.list = true

local cellwidths = vim.fn.getcellwidths()

-- 3点リーダ
table.insert(cellwidths, { 0x2026, 0x2026, 1 })

-- Unicode Standard Miscellaneous Symbols
table.insert(cellwidths, { 0x2600, 0x26ff, 1 })

-- Seti-UI + Custom
table.insert(cellwidths, { 0xe5fa, 0xe6ac, 1 })

-- Devicons
table.insert(cellwidths, { 0xe700, 0xe7c5, 1 })

-- Font Awesome
table.insert(cellwidths, { 0xf000, 0xf2e0, 1 })

-- Font Awesome Extension
table.insert(cellwidths, { 0xe200, 0xe2a9, 1 })

-- Material Design Icons
table.insert(cellwidths, { 0xf0001, 0xf1af0, 1 })

-- Weather
table.insert(cellwidths, { 0xe300, 0xe3e3, 1 })

-- Octicons
table.insert(cellwidths, { 0xf400, 0xf532, 1 })

-- Powerline Symbols
table.insert(cellwidths, { 0xe0a0, 0xe0a2, 1 })
table.insert(cellwidths, { 0xe0b0, 0xe0b3, 1 })

-- Powerline Extra Symbols
table.insert(cellwidths, { 0xe0a3, 0xe0a3, 1 })
table.insert(cellwidths, { 0xe0b4, 0xe0c8, 1 })
table.insert(cellwidths, { 0xe0ca, 0xe0ca, 1 })
table.insert(cellwidths, { 0xe0cc, 0xe0d4, 1 })

-- IEC Power Symbols
table.insert(cellwidths, { 0x23fb, 0x23fe, 1 })
table.insert(cellwidths, { 0x2b58, 0x2b58, 1 })

-- Font Logos
table.insert(cellwidths, { 0xf300, 0xf32f, 1 })

-- Pomicons
table.insert(cellwidths, { 0xe000, 0xe00a, 1 })

-- Codicons
table.insert(cellwidths, { 0xea60, 0xebeb, 1 })

-- Heavy Angle Brackets
table.insert(cellwidths, { 0x276c, 0x2771, 1 })

-- Box Drawing
table.insert(cellwidths, { 0x2500, 0x259f, 1 })

table.insert(cellwidths, { 0xf36f, 0xf36f, 2 })
vim.fn.setcellwidths(cellwidths)
vim.api.nvim_set_var("mapleader", " ")
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("n", "gj", "j", { noremap = true })
vim.keymap.set("n", "gk", "k", { noremap = true })
vim.keymap.set("i", "っｊ", "<Esc>", { noremap = true })
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')
vim.keymap.set("n", "<C-n>", ":bnext<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", ":bprevious<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>s", ":split<Return><C-w>w", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>v", ":vsplit<Return><C-w>w", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("c", "<C-p>", '<C-r>"', { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>r", ":source ~/.config/nvim/init.lua<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>w", ":w<Return>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>q", ":q<Return>", { noremap = true, silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
local signs = { Error = "", Warn = "", Info = "", Hint = "󰌶" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

if vim.fn.has("win32") == 1 then
	vim.api.nvim_set_option_value("shell", "powershell", {})
	vim.api.nvim_set_option_value("guifont", "PlemolJP Console NF:h18", {})
else
	vim.api.nvim_set_option_value("guifont", "PlemolJP Console NF,Apple Color Emoji:h18", {})
end

if vim.g.neovide then
	vim.api.nvim_set_option_value("guifont", "PlemolJP Console NF,Apple Color Emoji:h18", {})
	vim.g.neovide_padding_top = 20
	vim.g.neovide_padding_bottom = 10
	vim.g.neovide_padding_right = 20
	vim.g.neovide_padding_left = 20
	-- vim.g.neovide_transparency = 0.73
	vim.g.neovide_transparency = 0.85
	vim.g.neovide_fullscreen = false
	vim.g.neovide_remember_window_size = false
	vim.api.nvim_set_option_value("pumblend", 30, {})
	vim.api.nvim_set_option_value("winblend", 100, {})
	vim.g.neovide_floating_z_height = 4
	vim.g.neovide_input_ime = true
	vim.g.neovide_hide_mouse_when_typing = true
end

-- plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
local opts = {
	ui = {
		border = "rounded",
	},
}

require("lazy").setup(plugins, opts)
