-- make nvim transparent
local M = {
    "xiyaowong/transparent.nvim",
}

M.config = function()
    require("transparent").setup({
        extra_groups = {
            "NormalFloat",
            "FloatBorder",
            "NeoTreeNormal",
            "NeoTreeNormalNC",
            "NvimTreeNormal",
        },
    })
    require("transparent").clear_prefix("NeoTree")
    require("transparent").clear_prefix("BufferLine")
    require("transparent").clear_prefix("TabLine")
end

return M
