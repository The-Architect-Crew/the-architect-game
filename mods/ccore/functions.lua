-- Public functions for shared use by mods
<<<<<<< HEAD
function ccore.notify(playername, text, timeout)
    assert(ccore._notify, "ccore._notify not found")
    ccore._notify(playername, text, timeout)
=======
function core.notify(playername, text, timeout)
    -- Wrapper function for notify.lua
    assert(core._notify, "core._notify not found")
    core._notify(playername, text, timeout)
>>>>>>> dd5d65cda742a7346149316bbba468e3748c3811
end

