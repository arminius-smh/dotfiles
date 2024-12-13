-- escape insert mode
local M = {
    "max397574/better-escape.nvim",
}

M.config = function()
    require("better_escape").setup({
        timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    })
end

return M
