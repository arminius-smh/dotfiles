-- formatter
local M = {
    "stevearc/conform.nvim",
}

local function prettier_config()
    local file_extension = vim.fn.expand("%:e")
    local tab2 = { "yaml", "yml", "html" }
    if vim.tbl_contains(tab2, file_extension) then
        return vim.fn.expand("$HOME/.config/prettier/prettierrc-tab-2.json")
    else
        return vim.fn.expand("$HOME/.config/prettier/prettierrc-tab-4.json")
    end
end

local function clang_format_config()
    local no_file = { "-style=file:" .. vim.fn.expand("$HOME/.config/clang-format/clang-format") }
    local file_found = {}

    -- TODO: recursive search
    if vim.fn.filereadable(".clang-format") == 1 then
        return file_found
    else
        return no_file
    end
end

M.config = function()
    require("conform").setup({
        formatters_by_ft = {
            sh = { "beautysh" },
            zsh = { "beautysh" }, -- not intended
            python = { "black" },
            nix = { "alejandra" },
            markdown = { "markdownlint" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            arduino = { "clang_format" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            html = { "prettierd" },
            template = { "djlint" },
            css = { "prettierd" },
            json = { "prettierd" },
            yaml = { "prettierd" },
            typst = { "typstyle" },
        },

        formatters = {
            clang_format = {
                prepend_args = clang_format_config()
            },
            djlint = {
                prepend_args = {"--profile=golang"}
            },
            prettierd = {
                env = {
                    PRETTIERD_DEFAULT_CONFIG = prettier_config()
                },
            },
            uncrustify = {
                env = {
                    UNCRUSTIFY_CONFIG = vim.fn.expand("$HOME/.config/uncrustify/uncrustify.cfg")
                },
            },
        }
    })
end

return M
