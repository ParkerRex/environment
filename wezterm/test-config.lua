local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Test with a visible change
config.color_scheme = "Dracula"
config.font_size = 20
config.default_cursor_style = "BlinkingBlock"

return config