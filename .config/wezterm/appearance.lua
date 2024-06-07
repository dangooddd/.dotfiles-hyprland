local wezterm = require "wezterm"

local appearance = {
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    color_scheme = "Kanagawa (Gogh)",
    font = wezterm.font "Cascadia Code",
    font_size = 16,
    default_cursor_style = "SteadyBar",
    animation_fps = 60,
    custom_block_glyphs = false,
} 

local colors = {
    bg = "#1F1F28",
    fg = "#DCD7BA",
    bg_dark = "#090909",
    fg_bright = "#E6C384",
}

appearance.colors = {
    tab_bar = {
        active_tab = {
            bg_color = colors.bg,
            fg_color = colors.fg_bright,
        },
        
        inactive_tab = {
            bg_color = colors.bg_dark,
            fg_color = colors.fg,
        },

        inactive_tab_hover = {
            bg_color = colors.bg,
            fg_color = colors.fg,
        },

        new_tab = {
            bg_color = colors.bg_dark,
            fg_color = colors.fg,
        },

        new_tab_hover = {
            bg_color = colors.bg,
            fg_color = colors.fg_bright,
        },
    }
}

appearance.window_frame = {
    active_titlebar_bg = colors.bg_dark,
    inactive_titlebar_bg = colors.bg_dark,

    active_titlebar_fg = colors.fg,
    inactive_titlebar_fg = colors.fg,
}

appearance.window_padding = {
    left = "1cell",
    right = "0cell",
    top = "0cell",
    bottom = "0cell",
}

appearance.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 1.0,
}

return appearance
