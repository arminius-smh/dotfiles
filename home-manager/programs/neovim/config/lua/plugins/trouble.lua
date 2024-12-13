-- lsp diagnostics
local M = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
M.config = function()
    require("trouble").setup()
end

return M
