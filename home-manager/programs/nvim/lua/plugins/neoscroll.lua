-- smooth scrolling
local M = {
    "karb94/neoscroll.nvim",
}

M.config = function()
    require('neoscroll').setup()
end

return M
