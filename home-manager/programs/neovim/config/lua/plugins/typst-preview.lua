-- typst preview
local M = {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "0.3.*",
    build = function()
        require("typst-preview").update()
    end,
}

M.config = function()
    require("typst-preview").setup()
end

return M
