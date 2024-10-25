-- highlight and search for todo comments
local M = {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
    require("todo-comments").setup({
        keywords = {
            WAIT = { icon = "", color = "error" },
        },
    })
end

return M
