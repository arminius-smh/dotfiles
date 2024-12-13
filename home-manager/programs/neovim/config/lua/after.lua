-- local shiftwidth
vim.cmd([[
    autocmd FileType markdown,nix,yaml setlocal shiftwidth=2
]])

-- tabs instead of spaces
vim.cmd([[
    autocmd FileType go setlocal noexpandtab
]])

-- disable nvim-cmp
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "*.norg",
    callback = function()
        require("cmp").setup.buffer({ enabled = false })
    end,
})

-- autoindent all lines
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = "*.norg",
    callback = function()
        local last_cursor_pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[
            silent! normal! ggVG==
        ]])
        vim.api.nvim_win_set_cursor(0, last_cursor_pos)
    end,
})
