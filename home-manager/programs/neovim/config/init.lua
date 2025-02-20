-- PRE-PLUGIN CONFIG
vim.g.loaded_netrw = 1 -- disable builtin file explorer
vim.g.loaded_netrwPlugin = 1 -- disable builtin file explorer
vim.opt.termguicolors = true -- *IMPORTANT* for color scheme
vim.opt.timeoutlen = 300 -- for which-key popup time
vim.opt.splitright = true -- open a new file on the right hand site when vertical split
vim.opt.conceallevel = 3 -- conceal format text
vim.opt.number = true -- absolute side numbers
vim.opt.relativenumber = true -- relative side numbers
vim.opt.clipboard = "unnamedplus" -- clipboard copy
vim.opt.cmdheight = 2 -- disables "Press ENTER or type command to continue" for large cmd output
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 4 -- amount of spaces for each indentation
vim.opt.smartindent = true -- auto-indent new lines
vim.opt.tabstop = 4 -- width of tab
vim.opt.softtabstop = 4 -- amount of spaces to delete
vim.opt.swapfile = false -- disable swapfile
vim.opt.ignorecase = true -- ignore case for searches
vim.opt.smartcase = true --override ignorecase for uppercase characters
vim.opt.mouse = "a" -- enable mouse support
vim.opt.breakindent = true -- wrapped line will continue visually indented
vim.opt.scrolloff = 8 -- start scrolling 8 lines before the edge

vim.opt.list = true -- show symbols for tabs, trailing spaces and non-breakable space
-- vim.opt.listchars:append "space:⋅" -- dots instead of spaces
vim.opt.listchars:append("eol:↴") -- arrow at eol
vim.opt.listchars:append("tab:| ") -- vertical line at tabs
vim.cmd([[autocmd BufEnter * syntax sync minlines=4000]]) -- buffer larger files for syntax highlighting
vim.loader.enable() -- byte-compiles and caches lua files
------------
require("keybindings") -- custom keybindings
-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", {
    lockfile = os.getenv("HOME") .. "/dotfiles/home-manager/programs/neovim/config" .. "/lazy-lock.json",
    ui = {
        border = "rounded",
    },
})
-- POST-PLUGIN CONFIG
-- use nvim-lsp for code folding
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- colorscheme
-- options: sonokai, tokyonight, kangawa, catppuccin
-- NOTE: sonokai strikethrough is broken
vim.api.nvim_cmd({ cmd = "colorscheme", args = { "tokyonight" } }, {})
-- transparent
vim.g.transparent_enabled = true
-- copilot
vim.g.copilot_filetypes = {
    markdown = false,
    norg = false,
}
-- automatically update nix fetchgit
vim.cmd([[
    function! Preserve(command)
      let w = winsaveview()
      execute a:command
      call winrestview(w)
    endfunction

    autocmd FileType nix map <nowait> <leader>ü :call Preserve("%!update-nix-fetchgit --location=" . line(".") . ":" . col("."))<CR>
]])

-- open helpfiles in new buffer
vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "*",
    callback = function(event)
        if vim.bo[event.buf].filetype == "help" then
            vim.cmd.only()
            vim.bo[event.buf].buflisted = true
        end
    end,
})

-- hyprlang filetype
vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

require("after") -- post-nvim configuration
