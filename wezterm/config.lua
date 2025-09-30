local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Performance optimizations for Apple Silicon
config.front_end = "WebGpu" -- fastest rendering on Apple Silicon
config.webgpu_power_preference = "HighPerformance"
config.enable_wayland = false

-- Font configuration with fallbacks
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
config.font_size = 13.5
config.line_height = 1.25
config.cell_width = 1.05  -- widens characters a touch
config.freetype_load_flags = "NO_HINTING"

-- Cursor settings
config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 500

-- Animation and performance
config.animation_fps = 120
config.max_fps = 120

-- Tab bar configuration
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.enable_tab_bar = true -- if you prefer multiplexers like tmux

-- Window settings
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.check_for_updates = false
config.use_ime = true
config.scrollback_lines = 10000
config.window_padding = {
	left = 7,
	right = 0,
	top = 2,
	bottom = 0,
}
config.background = {
	{
		source = {
			File = "/Users/" .. os.getenv("USER") .. "/.config/wezterm/dark-desert.jpg",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.02,
			brightness = 0.25,
		},
		-- attachment = { Parallax = 0.3 },
		-- width = "100%",
		-- height = "100%",
	},
	{
		source = {
			Color = "#282c35",
		},
		width = "100%",
		height = "100%",
		-- opacity = 0.55,
		opacity = 0.75,
		-- opacity = 1,
	},
}
-- config.window_background_opacity = 0.3
-- config.macos_window_background_blur = 20
config.keys = {
	-- Tab management
	{ key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	{ key = "r", mods = "CMD", action = wezterm.action.PromptInputLine({
		description = "Enter new tab title:",
		action = wezterm.action_callback(function(window, pane, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	}) },
	-- Pane splitting
	{ key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	-- Special key handling
	{ key = "Enter", mods = "CTRL", action = wezterm.action({ SendString = "\x1b[13;5u" }) },
	{ key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b[13;2u" }) },
	-- Cmd+Delete to delete entire line (Ctrl+U in shell)
	{ key = "Backspace", mods = "CMD", action = wezterm.action({ SendString = "\x15" }) },
}
-- from: https://akos.ma/blog/adopting-wezterm/
config.hyperlink_rules = {
	-- Matches: a URL in parens: (URL)
	{
		regex = "\\((\\w+://\\S+)\\)",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in brackets: [URL]
	{
		regex = "\\[(\\w+://\\S+)\\]",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in curly braces: {URL}
	{
		regex = "\\{(\\w+://\\S+)\\}",
		format = "$1",
		highlight = 1,
	},
	-- Matches: a URL in angle brackets: <URL>
	{
		regex = "<(\\w+://\\S+)>",
		format = "$1",
		highlight = 1,
	},
	-- Then handle URLs not wrapped in brackets
	{
		regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
		format = "$1",
		highlight = 1,
	},
}
return config
