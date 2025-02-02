-- lsp config
local M = {
    "neovim/nvim-lspconfig",
}

M.config = function()
    local dotfiles_path = os.getenv("DOTFILES_PATH")

    local nvim_lsp = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }

    local server_list = {
        "rust_analyzer",
        "hyprls",
        "nixd",

        "bashls",
        "ccls",
        "denols",
        "emmet_ls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "lemminx",
        "lua_ls",
        "marksman",
        "pyright",
        "stylelint_lsp",
        "svelte",
        "swift_mesonls",
        "tinymist",
        "ts_ls",
        "vala_ls",
        "yamlls",
    }

    -- if lsp isn't installed globally and only used in flakes,
    -- ignore startup to supress errors for simply expecting files in a project without setup
    -- https://stackoverflow.com/questions/75397223/can-i-configure-nvim-lspconfig-to-fail-silently-rather-than-print-a-warning
    local function lsp_binary_exists(server)
        local binary = nvim_lsp[server].document_config.default_config.cmd[1]

        return vim.fn.executable(binary) == 1
    end

    local function lsp_config(server)
        if lsp_binary_exists(server) then
            local config = {
                capabilities = capabilities,
            }

            -- https://docs.deno.com/runtime/getting_started/setup_your_environment/#neovim-0.6%2B-using-the-built-in-language-server
            if server == "denols" then
                config.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc")
            end
            if server == "ts_ls" then
                config.root_dir = nvim_lsp.util.root_pattern("package.json")
                config.single_file_support = false
            end

            if server == "lua_ls" then
                config.on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            version = "LuaJIT",
                        },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME,
                                "${3rd}/luv/library",
                            },
                        },
                    })
                end
                config.settings = {
                    Lua = {},
                }
            end

            if server == "eslint" then
                config.on_attach = function(_, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end
            end

            if server == "nixd" then
                config.settings = {
                    nixd = {
                        options = {
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
                }
            end

            if server == "lemminx" then
                config.settings = {
                    xml = {
                        server = {
                            workDir = "~/.cache/lemminx",
                        },
                    },
                }
            end

            nvim_lsp[server].setup(config)
        end
    end

    for _, server in ipairs(server_list) do
        lsp_config(server)
    end
end

return M
