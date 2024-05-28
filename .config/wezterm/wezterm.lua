local wezterm = require "wezterm"
local keybinds = require "keybinds"
local appearance = require "appearance"

function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

local config = wezterm.config_builder()
merge(config, keybinds)
merge(config, appearance)

return config
