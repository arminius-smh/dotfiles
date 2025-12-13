-- autopairs
local M = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
}

M.config = function()
    require("nvim-autopairs").setup({
        check_ts = true,
    })
end

return M
