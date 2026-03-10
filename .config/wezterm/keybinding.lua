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
        key = 't',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain'
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = wezterm.action.CloseCurrentTab { confirm = true },
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
    {
        key = 'l',
        mods = 'CTRL',
        action = wezterm.action.ShowLauncher,
    },
    {
        key = 'd',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowDebugOverlay,
    },
    {
        key = '-',
        mods = 'CTRL',
        action = wezterm.action.SplitVertical,
    },
    {
        key = '/',
        mods = 'CTRL',
        action = wezterm.action.SplitHorizontal,
    },
}
