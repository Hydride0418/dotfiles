local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "rose-pine-moon"
config.font_dirs = {
  os.getenv("HOME") .. "/.local/share/fonts/hack-nerd-font",
}
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
