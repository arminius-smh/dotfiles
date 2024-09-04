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


    local no_config = { 'typst_lsp', 'svelte', 'swift_mesonls', 'vala_ls', 'gopls', 'marksman', 'jsonls', 'html', 'cssls',
        'ccls', 'yamlls', 'bashls', 'pyright', 'ts_ls', 'nil_ls', 'emmet_ls', 'lemminx' }

    local function lsp_config(server)
        require('lspconfig')[server].setup {
            capabilities = capabilities,
        }
    end

    for _, server in ipairs(no_config) do
        lsp_config(server)
    end

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

    require('lspconfig').eslint.setup {
        capabilities = capabilities,
        on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    }

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
end

return M
