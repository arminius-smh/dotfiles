-- annotation generator
local M = {
    "danymat/neogen",
}

M.config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
end

return M
