-- horizontal highlights for text filetypes
local M = {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
}

M.config = function()
    require("headlines").setup()
end

return M
