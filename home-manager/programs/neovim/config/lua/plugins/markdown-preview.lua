-- markdown preview
local M = {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git restore .", -- git restore . fixes file tracking issue
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
}

M.config = function()
    vim.g.mkdp_browser = "firefox"
    vim.g.mkdp_theme = "light"
end

return M
