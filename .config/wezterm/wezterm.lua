local wezterm = require "wezterm"
local keybinds = require "modules/keybinds"
local appearance = require "modules/appearance"

function merge(t1, t2)
    for k, v in pairs(t2) do
        t1[k] = v
    end
end

local config = wezterm.config_builder()
merge(config, keybinds)
merge(config, appearance)

return config
