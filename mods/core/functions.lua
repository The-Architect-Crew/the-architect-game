-- Public functions for shared use by mods
function core.notify(playername, text, timeout)
    assert(core._notify, "core._notify not found")
    core._notify(playername, text, timeout)
end

