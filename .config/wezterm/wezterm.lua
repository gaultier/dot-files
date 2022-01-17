local wezterm = require 'wezterm';

return {
  color_scheme = "ChallengerDeep",
  keys = {
    {key="z", mods="ALT", action="TogglePaneZoomState"},
    {key="l", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="h", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="j", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="k", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="-", mods="ALT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="\\", mods="ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
  }
}
