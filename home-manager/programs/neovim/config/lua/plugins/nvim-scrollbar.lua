-- scrollbar
local M = {
    "petertriho/nvim-scrollbar",
    enabled = false,
}

M.config = function()
    require("scrollbar").setup({
        handle = {
            color = "#1e1e2e",
        },
        marks = {
            Search = { color = "#ff9e64" },
            Error = { color = "#db4b4b" },
            Warn = { color = "#e0af68" },
            Info = { color = "#0db9d7" },
            Hint = { color = "#1abc9c" },
            Misc = { color = "#9d7cd8" },
        },
    })
    require("scrollbar.handlers.gitsigns").setup()
end

return M
