-- terminal toggle
local M = {
    "akinsho/toggleterm.nvim",
}

M.config = function()
    require("toggleterm").setup({
        open_mapping = [[<c-t>]],
        direction = "float",
    })
end

return M
