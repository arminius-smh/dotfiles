-- keybind popup-menu
local M = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = function()
    local wk = require("which-key")

    wk.setup({
        preset = 'modern',
    })

    wk.add({
        -- { "<leader><space>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Nvim-Tree" },
        { "<leader><space>", "<cmd>Neotree toggle reveal right<CR>",                                        desc = "Toggle Neo-Tree" },

        { "<leader>.",       "<cmd>Trouble diagnostics toggle<CR>",                                         desc = "Toggle Trouble" },
        { "<leader>-",       "<cmd>Trouble todo toggle<CR>",                                                desc = "Toggle Trouble Todo" },
        { "<leader>b",       "<cmd>BufferLinePick<CR>",                                                     desc = "Pick BufferLine" },
        { "<leader>r",       ":IncRename ",                                                                 desc = "Rename" },
        { "<leader>c",       "<cmd>foldclose<CR>",                                                          desc = "Close Codefold" },
        { "<leader>o",       "<cmd>foldopen<CR>",                                                           desc = "Open Codefold" },
        { "<leader>F",       "<cmd>lua require('conform').format({async = true, lsp_fallback = true})<CR>", desc = "Format Code" },
        { "<leader>m",       "<cmd>MarkdownPreviewToggle<CR>",                                              desc = "Markdown Preview" },
        { "<leader>g",       "<cmd>Copilot disable<CR>",                                                    desc = "Disable Copilot" },
        { "<leader>w",       "<cmd>%s/\\s\\+$//e<CR>",                                                      desc = "Remove Whitespace" },
        { "<leader>l",       "<cmd>Telescope find_files<CR>",                                               desc = "Find Files" },
        { "<leader>G",       "<cmd>lua require('neogen').generate({type = 'func'})<CR>",                    desc = "Generate Neogen" },

        { "<leader>P",       group = "lazy" },
        { "<leader>Pi",      "<cmd>Lazy install<CR>",                                                       desc = "Install" },
        { "<leader>Ps",      "<cmd>Lazy sync<CR>",                                                          desc = "Sync" },
        { "<leader>Pl",      "<cmd>Lazy log<CR>",                                                           desc = "Logs" },
        { "<leader>Pu",      "<cmd>Lazy update<CR>",                                                        desc = "Update" },
        { "<leader>Pr",      "<cmd>Lazy restore<CR>",                                                       desc = "Restore" },

        { "<leader>u",       group = "DAP UI" },
        { "<leader>uu",      "<cmd>lua require('dapui').toggle()<CR>",                                      desc = "Toggle DAP-UI" },
        { "<leader>us",      "<cmd>lua require('dap').toggle_breakpoint()<CR>",                             desc = "Toggle Breakpoint" },

        { "<leader>d",       group = "LSP" },
        { "<leader>df",      "<cmd>lua vim.lsp.buf.format { async = true }<CR>",                            desc = "Format Code" },
        { "<leader>dn",      "<cmd>lua vim.lsp.buf.declaration()<CR>",                                      desc = "Declaration" },
        { "<leader>dm",      "<cmd>lua vim.lsp.buf.definition()<CR>",                                       desc = "Definition" },
        { "<leader>dh",      "<cmd>lua vim.lsp.buf.hover()<CR>",                                            desc = "Hover" },
        { "<leader>dc",      "<cmd>lua vim.lsp.buf.code_action()<CR>",                                      desc = "Code Action" },
        { "<leader>dd",      "<cmd>lua vim.diagnostic.goto_next()<CR>",                                     desc = "Next Diagnostic" },
        { "<leader>dp",      "<cmd>lua vim.diagnostic.goto_prev()<CR>",                                     desc = "Previous Diagnostic" },

        { "<leader>f",       group = "Telescope" },
        { "<leader>ff",      "<cmd>Telescope find_files<CR>",                                               desc = "Find Files" },
        { "<leader>fg",      "<cmd>Telescope git_files<CR>",                                                desc = "Find Git Files" },
        { "<leader>fs",      "<cmd>Telescope live_grep<CR>",                                                desc = "Live Grep" },
        { "<leader>fN",      "<cmd>Telescope notify<CR>",                                                   desc = "List Notify Messages" },
        { "<leader>fo",      "<cmd>Telescope oldfiles<CR>",                                                 desc = "Previously Opened Files" },

        { "<leader>N",       group = "Neorg" },
        { "<leader>Nd",      "<cmd>Neorg journal today<CR>",                                                desc = "Today's Journal Entry" }
    })
end

return M
