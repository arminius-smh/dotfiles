vim.g.mapleader = ','
vim.g.maplocalleader = ','
-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- CUSTOM KEYBINDINGS
map("n", "<esc>", "<CMD>noh<CR>")
map("n", "Zz", "<C-w>_ \\| <C-w>\\|")
map("n", "Zo", "<C-w>=")
map("i", "<C-c>", "copilot#Accept('<CR>')", { expr = true })
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- UNMAP KEYS
map("v", "<S-Up>", "<Nop>")
map("v", "<S-Down>", "<Nop>")
