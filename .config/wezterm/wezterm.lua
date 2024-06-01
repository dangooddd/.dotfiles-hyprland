local wezterm = require "wezterm"
local keybinds = require "keybinds"
local appearance = require "appearance"
local general = require "general"

function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

local config = wezterm.config_builder()
merge(config, keybinds)
merge(config, appearance)
merge(config, general)

return config
