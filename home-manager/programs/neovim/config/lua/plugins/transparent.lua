-- make nvim transparent
local M = {
    "xiyaowong/transparent.nvim",
}

M.config = function()
    require("transparent").setup({
        groups = {
            'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
            'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
            'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
            'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
            'EndOfBuffer',
        },
        extra_groups = {
            "NormalFloat", "FloatBorder", "NeoTreeNormal", "NeoTreeNormalNC", "NvimTreeNormal"
        },
    })
    require('transparent').clear_prefix('NeoTree')
    require('transparent').clear_prefix('BufferLine')
end

return M
