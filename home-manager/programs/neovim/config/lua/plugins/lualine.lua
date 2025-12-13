-- status line
local M = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
    require("lualine").setup({
        options = {
            theme = "tokyonight-storm",
        },
    })
end

return M
