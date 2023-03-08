local wezterm = require 'wezterm';

return {
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  exit_behavior = "Close",
  color_scheme = "Gruvbox Light",
  -- color_scheme = "ChallengerDeep",
    -- font = wezterm.font_with_fallback({
  --     "SauceCodePro Nerd Font",
  --     "JetBrains Mono",
  --   }),
  font_size = 12.0,
  scrollback_lines = 10000,
  keys = {
    {key=".", mods="ALT", action=wezterm.action{ActivateTabRelative=1}},
    {key=",", mods="ALT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="z", mods="ALT", action="TogglePaneZoomState"},
    {key="l", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="h", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="j", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="k", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="-", mods="ALT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="\\", mods="ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="x", mods="ALT", action=wezterm.action{CloseCurrentPane={confirm=true}}},
  }
}
