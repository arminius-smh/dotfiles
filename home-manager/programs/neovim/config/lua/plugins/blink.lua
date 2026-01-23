-- completion engine
local M = {
    "saghen/blink.cmp",
    version = "1.*",
}

M.config = function()
    require("blink.cmp").setup({
        snippets = { preset = "luasnip" },

        sources = {
            default = { "lazydev", "lsp", "path", "snippets" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
        },

        fuzzy = { implementation = "prefer_rust" },

        keymap = {
            preset = "default",
        },
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
            menu = {
                border = "rounded",
                draw = {
                    columns = {
                        { "label", "label_description", gap = 1 },
                        { "kind_icon", "kind", gap = 1 },
                    },
                },
            },
        },
    })
end

return M
