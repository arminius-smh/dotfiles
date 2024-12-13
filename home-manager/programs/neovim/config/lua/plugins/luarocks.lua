-- install luarocks with lazy
local function capture_command_output(command)
    local file = io.popen(command)
    local output = file:read("*all")
    file:close()
    return output
end

local M = {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    opts = {
        -- god forgive me, for I have sinned
        luarocks_build_args = {
            "--with-lua-include=" .. capture_command_output('readlink -f "$(which luajit)"')
                :gsub("/bin/luajit%-[%d%.]+", "")
                :gsub("\n$", "") .. "/include",
        },
    },
}

return M
