-- org-mode for neovim
local M = {
    "nvim-neorg/neorg",
    enable = false,
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
}

M.config = function()
    require("neorg").setup({
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {
                config = {
                    icons = {
                        code_block = {
                            conceal = true,
                        },
                    },
                },
            },
            ["core.keybinds"] = {
                config = {
                    hook = function(keybinds)
                        keybinds.remap_event(
                            "norg",
                            "n",
                            keybinds.leader .. "nc",
                            "core.looking-glass.magnify-code-block"
                        )
                    end,
                },
            },
            ["core.summary"] = {
                config = {
                    strategy = "by_path",
                },
            },
            ["core.dirman"] = {
                config = {
                    workspaces = {
                        notes = "~/notes",
                    },
                    default_workspace = "notes",
                },
            },
            ["core.journal"] = {
                config = {
                    journal_folder = "diary",
                },
            },
            ["core.export"] = {},
        },
    })
end

return M
