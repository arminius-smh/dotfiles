-- file explorer
local M = {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = false,
}

M.config = function()
    require("nvim-tree").setup({
        open_on_tab = false,
        update_cwd = true,
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    })
end

return M
