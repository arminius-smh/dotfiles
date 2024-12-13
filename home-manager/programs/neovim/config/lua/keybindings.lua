vim.g.mapleader = ","
vim.g.maplocalleader = ","
-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- CUSTOM KEYBINDINGS
map("n", "<esc>", "<CMD>noh<CR>") -- clear selectino on esc press
map("i", "<C-c>", "copilot#Accept('<CR>')", { expr = true }) -- accept copilot suggestion
-- move around in insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("v", "p", "P") -- don't copy visually selected content when pasted over

-- UNMAP KEYS
map("v", "<S-Up>", "<Nop>")
map("v", "<S-Down>", "<Nop>")

-- opening links with shift+click includes the eol character
-- remapping shift+click does not work.
-- the map function also doesn't work for ctrl+click
vim.cmd([[
  autocmd VimEnter * nmap <C-LeftMouse> <LeftMouse>gx
]])
