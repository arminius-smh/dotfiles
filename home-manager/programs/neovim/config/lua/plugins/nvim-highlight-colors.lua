-- highlight colors
local M = {
    "brenoprata10/nvim-highlight-colors",
}

M.config = function()
    require("nvim-highlight-colors").setup({
        ---'background'|'foreground'|'virtual'
        render = "background",
        virtual_symbol = "■",

        enable_named_colors = true,
        enable_tailwind = true,
    })
end

return M
