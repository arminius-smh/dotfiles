-- image support for neovim
local M = {
    "3rd/image.nvim",
    build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
}

M.config = function()
    require("image").setup({
        backend = "kitty",
    })
end

return M
