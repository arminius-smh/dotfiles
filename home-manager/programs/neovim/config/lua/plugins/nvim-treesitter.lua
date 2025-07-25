-- syntax highlighting
local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
}

M.config = function()
    require("nvim-treesitter.configs").setup({
        auto_install = true,
        indent = { enable = true },
        highlight = {
            enable = true,
            -- disable slow treesitter highlight for large files
            disable = function(_, buf)
                local max_filesize = 200 * 1024 -- 200 KB
                local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
    })
end

return M
