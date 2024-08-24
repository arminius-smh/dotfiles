-- desc
local M = {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
    },
}

M.config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local fmt = require("luasnip.extras.fmt").fmt
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_snipmate").lazy_load()

    ls.add_snippets("lua", {
        s({
            trig = "plugin",
            name = "Plugin Template",
            desc = "Plugin Template for Lazy",
        }, fmt(
            [[
                -- {}
                local M = {{
                    "{}",
                }}

                M.config = function()
                    require("{}").setup()
                end

                return M
            ]], {
                i(1, "description"), i(2, "source"), i(0, "name")
            }
        ))
    })

    ls.add_snippets("sh", {
        s({
            trig = "bashmain",
            name = "Main Function",
            desc = "Main Function Template",
        }, fmt(
            [[
                #!/usr/bin/env bash
                main() {{
                    echo "Hello, World!"
                }}

                main "$@"
            ]], {}
        ))
    })
end

return M
