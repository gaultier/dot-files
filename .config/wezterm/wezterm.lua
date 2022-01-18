local wezterm = require 'wezterm';

return {
  color_scheme = "ChallengerDeep",
  font = wezterm.font_with_fallback({
      "SauceCodePro Nerd Font",
      "JetBrains Mono",
    }),
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
  }
}
