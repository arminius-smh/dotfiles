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
end

return M
