-- https://github.com/perogiue/mpv-scripts
local mp = require("mp")

local platform = io.popen("uname -s"):read("*a"):gsub("%s+", "")

local function escape(s)
    return (s:gsub("'", "'\\''"))
end

local function copy_sub(prop, subtext)
    if subtext and subtext ~= "" then
        if platform == "Darwin" then
            os.execute("export LANG=en_US.UTF-8; echo '" .. escape(subtext) .. "' | pbcopy")
        elseif platform == "Linux" then
            os.execute("echo '" .. escape(subtext) .. "' | wl-copy")
        end
    end
end

local function toggle_subs_to_clipboard()
    if _G.autocopysubs then
        mp.osd_message("Auto-copy subs disabled", 1)
        mp.unobserve_property(copy_sub)
        _G.autocopysubs = false
    else
        mp.osd_message("Auto-copy subs enabled", 1)
        mp.observe_property("sub-text", "string", copy_sub)
        _G.autocopysubs = true
    end
end

mp.observe_property("sub-text", "string", copy_sub)
_G.autocopysubs = true
mp.add_key_binding(nil, "toggle-subs-to-clipboard", toggle_subs_to_clipboard)
