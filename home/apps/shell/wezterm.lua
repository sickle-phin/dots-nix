local wezterm = require("wezterm")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.front_end = "WebGpu"
config.term = "wezterm"
config.color_scheme = 'catppuccin-mocha'
config.font_size = 19.5
config.window_background_opacity = 0.60
config.text_background_opacity = 1.0
config.use_ime = true
config.enable_tab_bar = false
-- config.disable_default_key_bindings = true
config.enable_wayland = true
config.hide_mouse_cursor_when_typing = false
config.alternate_buffer_wheel_scroll_speed = 1

config.font = wezterm.font_with_fallback({
	{ family = "PlemolJP Console NF" },
	{ family = "Plemol JPConsole NF", assume_emoji_presentation = true },
	{ family = "Apple Color Emoji" },
})
-- config.font = wezterm.font {
--     family = 'HackGen Console NF',
--     harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
-- }

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "HackGen Console NF", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 15.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#010b2c",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#010b2c",
}

config.colors = {
	background = "#000000",
	cursor_bg = "#f4b7d6",
	cursor_fg = "#000000",
	cursor_border = "#f4b7d6",
	tab_bar = {
		-- The color of the strip that goes along the top of the window
		-- (does not apply when fancy tab bar is in use)
		background = "#010b2c",

		-- The active tab is the one that has focus in the window
		active_tab = {
			-- The color of the background area for the tab
			bg_color = "#f477b6",
			-- The color of the text for the tab
			fg_color = "#000000",

			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			-- label shown for this tab.
			-- The default is "Normal"
			intensity = "Normal",

			-- Specify whether you want "None", "Single" or "Double" underline for
			-- label shown for this tab.
			-- The default is "None"
			underline = "None",

			-- Specify whether you want the text to be italic (true) or not (false)
			-- for this tab.  The default is false.
			italic = false,

			-- Specify whether you want the text to be rendered with strikethrough (true)
			-- or not for this tab.  The default is false.
			strikethrough = false,
		},

		inactive_tab = {
			bg_color = "#233b6c",
			fg_color = "#ffffff",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over inactive tabs
		inactive_tab_hover = {
			bg_color = "#ec6a88",
			fg_color = "#000000",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `inactive_tab_hover`.
		},
		-- The new tab button that let you create new tabs
		new_tab = {
			bg_color = "#233b6c",
			fg_color = "#ffffff",

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab`.
		},

		-- You can configure some alternate styling when the mouse pointer
		-- moves over the new tab button
		new_tab_hover = {
			bg_color = "#ec6a88",
			fg_color = "#000000",
			italic = true,

			-- The same options that were listed under the `active_tab` section above
			-- can also be used for `new_tab_hover`.
		},
	},
}

config.keys = {
	{ key = "t", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "s", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "q", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "h", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
	{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
	{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
	{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
	{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
	{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
	{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
	{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
	{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(-1) },
	{ key = "p", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "k", mods = "ALT", action = act.ScrollByLine(-1) },
	{ key = "j", mods = "ALT", action = act.ScrollByLine(1) },
}

return config
