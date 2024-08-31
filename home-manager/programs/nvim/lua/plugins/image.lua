-- image support for neovim
local M = {
    "3rd/image.nvim",
    enabled = false, -- NOTE: something wrong in the build process
}

M.config = function()
    require("image").setup({
        -- NOTE: Ueberzeugpp could work as well, but issue with wayland rn
        backend = "kitty",
        integrations = {
            neorg = {
                enabled = true,
                clear_in_insert_mode = true, -- NOTE: Otherwise extremly flashy
            }
        }
    })
end

return M
