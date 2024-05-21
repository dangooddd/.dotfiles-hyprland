local wezterm = require "wezterm"
local act = wezterm.action

local keybinds = {
    keys = {
        -- general move
        { key = "q", mods = "CTRL", action = act.CloseCurrentTab { confirm = true } },
        { key = "n", mods = "CTRL", action = act.SpawnTab "CurrentPaneDomain" },
        { key = "h", mods = "CTRL", action = act.ActivateTabRelative(-1) },
        { key = "l", mods = "CTRL", action = act.ActivateTabRelative(1) },
        { key = "l", mods = "CTRL|ALT", action = act.ShowLauncherArgs { flags = "WORKSPACES|DOMAINS" } },
        -- panes
        { key = "p", mods = "ALT", action = act.ActivateKeyTable { name = "pane_mode", one_shot = false } },
        { key = "r", mods = "ALT", action = act.ActivateKeyTable { name = "resize_mode", one_shot = false } },
        { key = "q", mods = "ALT", action = act.CloseCurrentPane { confirm = false } },
        { key = "h", mods = "ALT", action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = "ALT", action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = "ALT", action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = "ALT", action = act.ActivatePaneDirection "Right" },
        -- Clipboard
        { key = "v", mods = "CTRL", action = act.PasteFrom "Clipboard" },
        { key = "c", mods = "CTRL", action = act.CopyTo "ClipboardAndPrimarySelection" },
    },
    key_tables = {
        pane_mode = {
            -- open/close panes
            { key = "h", action = act.SplitPane { direction = "Left" } },
            { key = "j", action = act.SplitPane { direction = "Down" } },
            { key = "k", action = act.SplitPane { direction = "Up" } },
            { key = "l", action = act.SplitPane { direction = "Right" } },
            { key = "Escape", action = act.PopKeyTable },
        },
        resize_mode = {
            -- resize panes
            { key = "h", action = act.AdjustPaneSize { "Left", 5 } },
            { key = "j", action = act.AdjustPaneSize { "Down", 5 } },
            { key = "k", action = act.AdjustPaneSize { "Up", 5 } },
            { key = "l", action = act.AdjustPaneSize { "Right", 5 } },
            { key = "Escape", action = act.PopKeyTable },
        }
    },
}

-- tab movement
for i = 1, 10 do 
    table.insert(keybinds.keys, {
        key = tostring(i%10),
        mods = "CTRL",
        action = act.ActivateTab(i-1)
    })
end

return keybinds
