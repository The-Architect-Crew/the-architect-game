-- Public functions for shared use by mods
function ccore.notify(playername, text, timeout)
    assert(ccore._notify, "ccore._notify not found")
    ccore._notify(playername, text, timeout)
end

