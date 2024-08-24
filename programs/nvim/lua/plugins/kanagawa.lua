-- colorscheme
local M = {
    "rebelot/kanagawa.nvim",
}

M.config = function()
    require("kanagawa").setup({
        transparent = true,
    })
end

return M
