local wezterm = require "wezterm"

local appearance = {
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    color_scheme = "Kanagawa (Gogh)",
    font = wezterm.font "Cascadia Code",
    font_size = 16,
} 

local colors = {
    bg = "#1f1f28",
    fg = "#dcd7ba",
    bg_dark = "#10101d",
    color3 = "#e6c384",
}

appearance.colors = {
    tab_bar = {
        active_tab = {
            bg_color = colors.bg,
            fg_color = colors.color3,
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
            fg_color = colors.color3,
        },
    }
}

appearance.window_frame = {
    active_titlebar_bg = "#101016",
    inactive_titlebar_bg = "#101016",

    active_titlebar_fg = "#dcd7ba",
    inactive_titlebar_fg = "#dcd7ba",
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
