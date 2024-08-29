-- lsp config
local M = {
    "neovim/nvim-lspconfig",
    dependencies = { "folke/neodev.nvim" },
}

M.config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright
    -- python
    require('lspconfig')['pyright'].setup {
        capabilities = capabilities,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
    -- typescript
    require('lspconfig')['tsserver'].setup {
        capabilities = capabilities,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#nil_ls
    -- nix
    require('lspconfig')['nil_ls'].setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
    -- lua
    require('lspconfig').lua_ls.setup {
        capabilities = capabilities,
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            })
        end,
        settings = {
            Lua = {}
        }
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#emmet_ls
    -- emmet (html abbreviations)
    require('lspconfig').emmet_ls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lemminx
    -- xml
    require('lspconfig').lemminx.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
    -- bash
    require('lspconfig').bashls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
    -- yaml
    require('lspconfig').yamlls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd
    -- c, c++
    require('lspconfig').ccls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ccsls
    -- css, scss
    require('lspconfig').cssls.setup {
        capabilities = capabilities,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
    -- javascript/typescript lint
    require('lspconfig').eslint.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
    -- ht,ö
    require('lspconfig').html.setup {
        capabilities = capabilities,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
    -- json
    require('lspconfig').jsonls.setup {
        capabilities = capabilities,
    }
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#marksman
    -- markdown
    require('lspconfig').marksman.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    -- rust
    require('lspconfig').rust_analyzer.setup {
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                diagnostics = {
                    enable = true,
                }
            }
        }
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
    -- go
    require('lspconfig').gopls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vala_ls
    -- vala
    require 'lspconfig'.vala_ls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#swift_mesonls
    -- swift
    require 'lspconfig'.swift_mesonls.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
    -- svelte
    require 'lspconfig'.svelte.setup {
        capabilities = capabilities,
    }

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#typst_lsp
    require 'lspconfig'.typst_lsp.setup {
        capabilities = capabilities,
    }
end

return M
