-- bufferline
local M = {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
    require("bufferline").setup({
        options = {
            themeable = true,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true, -- use a "true" to enable the default, or set your own character
                },
            },
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icon = level:match("error") and " " or " "
                return " " .. icon .. count
            end,
        },
    })
end

return M
