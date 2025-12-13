-- keybind popup-menu
local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
    local wk = require("which-key")

    wk.setup({
        preset = "modern",
    })

    wk.add({
        { "<leader><space>", "<cmd>Neotree toggle reveal right<CR>", desc = "Toggle Neo-Tree" },

        { "<leader>.", "<cmd>Trouble diagnostics toggle<CR>", desc = "Toggle Trouble" },
        { "<leader>-", "<cmd>Trouble todo toggle<CR>", desc = "Toggle Trouble Todo" },
        { "<leader>b", "<cmd>BufferLinePick<CR>", desc = "Pick BufferLine" },
        { "<leader>r", ":IncRename ", desc = "Rename" },
        { "<leader>c", "<cmd>foldclose<CR>", desc = "Close Codefold" },
        { "<leader>o", "<cmd>foldopen<CR>", desc = "Open Codefold" },
        { "<leader>F", "<cmd>lua require('conform').format({async = true, lsp_fallback = true})<CR>", desc = "Format Code" },
        { "<leader>l", "<cmd>Telescope find_files<CR>", desc = "Find Files" },

        { "<leader>P", group = "lazy" },
        { "<leader>Pi", "<cmd>Lazy install<CR>", desc = "Install" },
        { "<leader>Ps", "<cmd>Lazy sync<CR>", desc = "Sync" },
        { "<leader>Pl", "<cmd>Lazy log<CR>", desc = "Logs" },
        { "<leader>Pu", "<cmd>Lazy update<CR>", desc = "Update" },
        { "<leader>Pr", "<cmd>Lazy restore<CR>", desc = "Restore" },

        { "<leader>d", group = "LSP" },
        { "<leader>df", "<cmd>lua vim.lsp.buf.format { async = true }<CR>", desc = "Format Code" },
        { "<leader>dn", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Declaration" },
        { "<leader>dm", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Definition" },
        { "<leader>dh", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
        { "<leader>dc", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
        { "<leader>dd", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
        { "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous Diagnostic" },

        { "<leader>f", group = "Telescope" },
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find Git Files" },
        { "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
        { "<leader>fN", "<cmd>Telescope notify<CR>", desc = "List Notify Messages" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Previously Opened Files" },
    })
end

return M
