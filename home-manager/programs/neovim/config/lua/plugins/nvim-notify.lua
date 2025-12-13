-- notification manager
local M = {
    "rcarriga/nvim-notify",
}

M.config = function()
    require("notify").setup()
    vim.notify = require("notify")
end

return M
