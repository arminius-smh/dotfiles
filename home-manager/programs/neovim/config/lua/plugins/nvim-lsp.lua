-- lsp config
local M = {
    "neovim/nvim-lspconfig",
}

M.config = function()
    local nvim_lsp = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }


    local no_config = { 'typst_lsp', 'svelte', 'swift_mesonls', 'vala_ls', 'gopls', 'marksman', 'jsonls', 'html', 'cssls',
        'ccls', 'yamlls', 'bashls', 'pyright', 'emmet_ls', 'lemminx' }

    local function lsp_config(server)
        nvim_lsp[server].setup {
            capabilities = capabilities,
        }
    end

    for _, server in ipairs(no_config) do
        lsp_config(server)
    end

    -- https://docs.deno.com/runtime/getting_started/setup_your_environment/#neovim-0.6%2B-using-the-built-in-language-server
    nvim_lsp.denols.setup {
        capabilities = capabilities,
        root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
    }
    nvim_lsp.ts_ls.setup {
        capabilities = capabilities,
        root_dir = nvim_lsp.util.root_pattern("package.json"),
        single_file_support = false
    }

    nvim_lsp.lua_ls.setup {
        capabilities = capabilities,
        on_init = function(client)
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
                return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                        "${3rd}/luv/library",
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

    require('lspconfig').nixd.setup {
        capabilities = capabilities,
        settings = {
            nixd = {
                nixpkgs = {
                    expr = 'import (builtins.getFlake ("git+file:///home/armin/dotfiles?submodules=1")).inputs.nixpkgs { }',
                },
                options = {
                    nixos = {
                        expr = '(builtins.getFlake ("git+file:///home/armin/dotfiles?submodules=1")).nixosConfigurations.phoenix.options',
                    },

                    -- is this the correct way to include this?
                    home_manager = {
                        expr = '(builtins.getFlake ("git+file:///home/armin/dotfiles?submodules=1")).nixosConfigurations.phoenix.options.home-manager.users.type.getSubOptions []',
                    },
                }
            }
        }
    }
end

return M
