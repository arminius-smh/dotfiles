-- LSP renaming with visual feedback
local M = {
    "smjonas/inc-rename.nvim",
}

M.config = function()
    require("inc_rename").setup()
end

return M
