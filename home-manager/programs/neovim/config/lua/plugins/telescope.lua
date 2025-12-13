-- fuzzy finder
local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
}

M.config = function()
    require("telescope").setup()

    require("telescope").load_extension("notify")
end

return M
