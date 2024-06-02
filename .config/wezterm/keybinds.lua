local wezterm = require "wezterm"
local act = wezterm.action
local paneMod = "ALT"          -- fast pane moves
local tabMod = "CTRL|ALT"      -- compatible tabs moves
local mainMod = "CTRL|SHIFT"   -- general mod

local keybinds = {
    keys = {
        -- general move
        { key = "q", mods = tabMod, action = act.CloseCurrentTab { confirm = true } },
        { key = "n", mods = tabMod, action = act.SpawnTab "CurrentPaneDomain" },
        { key = "h", mods = tabMod, action = act.ActivateTabRelative(-1) },
        { key = "l", mods = tabMod, action = act.ActivateTabRelative(1) },
        -- hack to remove SHIFT|SPACE escape sequence
        { key = "Space", mods = "SHIFT", action = act.Nop },
        -- panes
        { key = "p", mods = paneMod, action = act.ActivateKeyTable { name = "pane_mode", one_shot = false } },
        { key = "r", mods = paneMod, action = act.ActivateKeyTable { name = "resize_mode", one_shot = false } },
        { key = "q", mods = paneMod, action = act.CloseCurrentPane { confirm = false } },
        { key = "h", mods = paneMod, action = act.ActivatePaneDirection "Left" },
        { key = "j", mods = paneMod, action = act.ActivatePaneDirection "Down" },
        { key = "k", mods = paneMod, action = act.ActivatePaneDirection "Up" },
        { key = "l", mods = paneMod, action = act.ActivatePaneDirection "Right" },
        -- Clipboard
        { key = "v", mods = mainMod, action = act.PasteFrom "Clipboard" },
        { key = "c", mods = mainMod, action = act.CopyTo "ClipboardAndPrimarySelection" },
    },
    key_tables = {
        pane_mode = {
            -- open/close panes
            { key = "h", action = act.Multiple { act.SplitPane { direction = "Left" }, act.PopKeyTable } },
            { key = "j", action = act.Multiple { act.SplitPane { direction = "Down" }, act.PopKeyTable } },
            { key = "k", action = act.Multiple { act.SplitPane { direction = "Up" }, act.PopKeyTable } },
            { key = "l", action = act.Multiple { act.SplitPane { direction = "Right" }, act.PopKeyTable } },
            { key = "q", action = act.PopKeyTable },
            { key = "Escape", action = act.PopKeyTable },
        },
        resize_mode = {
            -- resize panes
            { key = "h", action = act.AdjustPaneSize { "Left", 5 } },
            { key = "j", action = act.AdjustPaneSize { "Down", 5 } },
            { key = "k", action = act.AdjustPaneSize { "Up", 5 } },
            { key = "l", action = act.AdjustPaneSize { "Right", 5 } },
            { key = "q", action = act.PopKeyTable },
            { key = "Escape", action = act.PopKeyTable },
        }
    },
}

-- tab movement
for i = 1, 10 do 
    table.insert(keybinds.keys, {
        key = tostring(i%10),
        mods = tabMod,
        action = act.ActivateTab(i-1)
    })
end

return keybinds
