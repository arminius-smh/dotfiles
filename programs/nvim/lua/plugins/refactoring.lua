-- refactoring library
local M = {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
}

M.config = function()
    require('refactoring').setup()
end

return M
