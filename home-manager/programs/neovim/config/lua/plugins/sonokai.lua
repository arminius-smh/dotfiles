-- colorscheme
local M = {
    "sainnhe/sonokai",
}

M.config = function()
    vim.g.sonokai_enable_italic = true
    vim.g.sonokai_style = "andromeda"
    vim.g.sonokai_better_performance = 1
end

return M
