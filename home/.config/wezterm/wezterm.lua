local wezterm = require("wezterm")
local act = wezterm.action

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
config.set_environment_variables = {
  NOSYSZSHRC = "1",
}
config.use_ime = true
config.hyperlink_rules = wezterm.default_hyperlink_rules()

local local_path = [[(/(?:[-A-Za-z0-9._+@%~=]+/)*[-A-Za-z0-9._+@%~=]+)]]
table.insert(config.hyperlink_rules, {
  regex = local_path .. [[:([0-9]+):([0-9]+)]],
  format = "file://$1#$2:$3",
})
table.insert(config.hyperlink_rules, {
  regex = local_path .. [[:([0-9]+)]],
  format = "file://$1#$2",
})
table.insert(config.hyperlink_rules, {
  regex = local_path,
  format = "file://$1",
})

wezterm.on("open-uri", function(window, pane, uri)
  if uri:find("^file:") ~= 1 then
    return
  end

  local url = wezterm.url.parse(uri)
  local file_path = url.file_path
  if not file_path or file_path == "" then
    return false
  end

  local lower_file_path = file_path:lower()
  if lower_file_path:match("%.md$") or lower_file_path:match("%.markdown$") then
    window:perform_action(
      act.SpawnCommandInNewTab({
        args = { "/opt/homebrew/bin/glow", "-p", file_path },
      }),
      pane
    )
    return false
  end

  local target = file_path
  if url.fragment and url.fragment ~= "" then
    target = target .. ":" .. url.fragment
  end

  local success = wezterm.run_child_process({
    "/opt/homebrew/bin/code",
    "--goto",
    target,
  })
  if not success then
    window:toast_notification("WezTerm", "Failed to open " .. target .. " in VS Code", nil, 4000)
  end
  return false
end)

config.mouse_bindings = {
  -- Open links with Command-click, including panes whose apps capture the mouse.
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CMD",
    action = act.Nop,
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "CMD",
    mouse_reporting = true,
    action = act.OpenLinkAtMouseCursor,
  },
  {
    event = { Down = { streak = 1, button = "Left" } },
    mods = "CMD",
    mouse_reporting = true,
    action = act.Nop,
  },
}
config.keys = {
  {
    key = "d",
    mods = "CMD",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentPane({ confirm = true }),
  },
  {
    key = "f",
    mods = "CMD",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
  {
    key = "F",
    mods = "CTRL|SHIFT",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
  {
    key = "f",
    mods = "CTRL|SHIFT",
    action = act.Search("CurrentSelectionOrEmptyString"),
  },
}

return config
