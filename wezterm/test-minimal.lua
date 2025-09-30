local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Minimal config with just the color scheme
config.color_scheme = "Nord (Gogh)"
config.font_size = 13.5

return config