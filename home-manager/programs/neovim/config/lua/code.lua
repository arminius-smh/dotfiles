local lint = require("lint")
local linters = require("lint").linters
local format = require("conform")

local dotfiles_path = os.getenv("HOME") .. "/dotfiles"

-- setup
format.setup()

-- bash
vim.lsp.enable("bashls") -- uses shellcheck for linting
format.formatters_by_ft.sh = { "shfmt" }

-- zsh
format.formatters_by_ft.zsh = { "shfmt" } -- not intended

-- lua
vim.lsp.config("lua_ls", {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
                path ~= vim.fn.stdpath("config")
                and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
vim.lsp.enable("lua_ls")
format.formatters_by_ft.lua = { "stylua" }

-- nix
vim.lsp.config("nixd", {
    settings = {
        nixd = {
            options = {
                formatting = {
                    command = { "nixfmt" },
                },
                nixos = {
                    expr = '(builtins.getFlake ("git+file://'
                        .. dotfiles_path
                        .. '?submodules=1")).nixosConfigurations.phoenix.options',
                },
                home_manager = {
                    expr = '(builtins.getFlake ("git+file://'
                        .. dotfiles_path
                        .. '?submodules=1")).nixosConfigurations.phoenix.options.home-manager.users.type.getSubOptions []',
                },
            },
        },
    },
})
vim.lsp.enable("nixd")

-- hypr config
vim.lsp.enable("hyprls")

-- qml
vim.lsp.config("qmlls", {
    cmd = { "qmlls", "-E" },
})
vim.lsp.enable("qmlls")

-- java
vim.lsp.enable("jdtls")
-- POST
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged", "TextChangedI" }, {
    callback = function()
        lint.try_lint()
    end,
})
