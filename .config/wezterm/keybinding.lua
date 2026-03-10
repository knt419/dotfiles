local wezterm = require 'wezterm'

return {
    { key = 'PageDown', mods = 'CTRL', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'PageUp',   mods = 'CTRL', action = wezterm.action.ActivateTabRelative(-1) },
    {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnCommandInNewTab {
            args = { 'nvim' }
        }
    },
    {
        key = 'Escape',
        mods = 'SHIFT',
        action = wezterm.action.ActivateCopyMode,
    },
    {
        key = ';',
        mods = 'CTRL',
        action = wezterm.action.ActivateCommandPalette,
    },
    {
        key = 'q',
        mods = 'CTRL',
        action = wezterm.action.QuickSelect,
    },
    {
        key = 'k',
        mods = 'CTRL',
        action = wezterm.action.CharSelect,
    },
}
