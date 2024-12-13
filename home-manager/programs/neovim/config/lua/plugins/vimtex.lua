-- latex support
local M = {
    "lervag/vimtex",
    ft = "tex",
}

M.config = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
end

return M
