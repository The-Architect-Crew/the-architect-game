-- Public functions for shared use by mods
function core.notify(playername, text, timeout)
    -- Wrapper function for notify.lua
    assert(core._notify, "core._notify not found")
    core._notify(playername, text, timeout)
end

