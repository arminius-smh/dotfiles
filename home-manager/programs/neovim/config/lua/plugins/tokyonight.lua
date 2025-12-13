-- colorscheme
local M = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
}

M.config = function()
    require("tokyonight").setup({
        style = "storm",
        transparent = true,
        styles = { sidebars = "transparent", floats = "transparent", comments = { italic = true } },
    })
end

return M
