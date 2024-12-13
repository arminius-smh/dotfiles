-- overall neovim experience improvements
local M = {
    "echasnovski/mini.nvim",
    version = false,
}

M.config = function()
    require("mini.surround").setup()
end

return M
