-- github copilot
local M = {
    "github/copilot.vim",
}

M.config = function()
    vim.g.copilot_no_tab_map = true -- allow remap
    vim.g.copilot_filetypes = { tex = false }
end

return M
