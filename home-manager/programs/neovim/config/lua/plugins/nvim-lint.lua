-- linter
local M = {
    "mfussenegger/nvim-lint",
}

M.config = function()
    local lint = require("lint")
    local linters = require("lint").linters

    lint.linters_by_ft = {
        markdown = { "markdownlint" },
        python = { "pylint" },
        sh = { "shellcheck" },
        css = { "stylelint" },
    }

    linters.markdownlint.args = {
        "--disable",
        "MD013",
        "MD024",
        "MD029",
        "MD033",
        "MD036",
        "--",
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
        callback = function()
            lint.try_lint()
        end,
    })
end

return M
