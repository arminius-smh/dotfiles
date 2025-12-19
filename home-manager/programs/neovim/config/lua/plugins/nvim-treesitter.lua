-- syntax highlighting
local M = {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
}

M.config = function()
    local parsers = {
        "lua",
        "nix",
    }
    require("nvim-treesitter").install(parsers)

    local exclude_parsers = {}
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("dotvim_treesitter-auto_install", { clear = true }),
        callback = function()
            local ft = vim.bo.filetype
            for _, parser in ipairs(exclude_parsers) do
                if ft == parser then
                    return
                end
            end
            if not parsers[ft] then
                require("nvim-treesitter").install(ft)
            end
        end,
    })
    vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("EnableTreesitter", { clear = true }),
        desc = "Try to enable tree-sitter",
        pattern = "*", -- run on *all* filetypes
        callback = function()
            pcall(function()
                -- Highlights
                vim.treesitter.start()

                -- Folds
                vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                vim.wo[0][0].foldmethod = "expr"

                -- Intendation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end)
        end,
    })
end

return M
