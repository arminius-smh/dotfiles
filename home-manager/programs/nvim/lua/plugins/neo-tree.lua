-- file explorer
local M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim"
    },
}

M.config = function()
    require("neo-tree").setup({
        filesystem = {
            hijack_netrw_behavior = "open_current",
        },
        follow_current_file = {
            enabled = true,
        },
        -- auto-close neo-tree
        event_handlers = {
            {
                event = "file_opened",
                handler = function(file_path)
                    require("neo-tree.command").execute({ action = "close" })
                end
            },

        }
    })
end

return M
