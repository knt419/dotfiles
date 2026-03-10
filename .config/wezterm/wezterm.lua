local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- base configuration
-- config.front_end = 'WebGpu'
config.use_ime = true
config.default_prog = { 'nu' }
config.canonicalize_pasted_newlines = 'LineFeed'

-- display
--- layout
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 16
config.font = wezterm.font('OperatorMono Nerd Font', {
    weight = 'Regular',
    stretch = 'Normal',
    style = 'Normal'
})
config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
config.show_tabs_in_tab_bar = true
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

--- appearance
config.color_scheme = 'Aquarium Dark'
config.window_background_opacity = 0.7
config.win32_system_backdrop = 'Acrylic'
config.show_close_tab_button_in_tabs = false

config.window_frame = {
    font = wezterm.font('OperatorMono Nerd Font', { weight = 'Bold' }),
    font_size = 13.0,
    inactive_titlebar_bg = 'none',
    active_titlebar_bg = 'none',
}

config.colors = {
    tab_bar = {
        inactive_tab_edge = 'none',
        new_tab = {
            fg_color = '#9a9eab',
            bg_color = 'none',
        },
    },
}

config.window_background_gradient = {
    colors = { "#000000" },
}

require 'tabbar'
require 'status'
config.keys = require 'keybinding'

-- Finally, return the configuration to wezterm:
return config
