-- improve the default vim.ui interfaces
local M = {
    "stevearc/dressing.nvim",
}

M.config = function()
    require("dressing").setup()
end

return M
