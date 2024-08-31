-- colorscheme
local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
}

M.config = function()
    require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
    })
end

return M
