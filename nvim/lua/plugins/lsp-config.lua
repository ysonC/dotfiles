return{
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",   --Lua
                    "pyright",  --Python
                    "gopls",     --Go
                    "yamlls"    --YAML
                }

            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")

            -- Lua Language Server
            lspconfig.lua_ls.setup({})

            -- Python Language Server
            lspconfig.pyright.setup({})

            -- YAML
            lspconfig.yamlls.setup({
                settings = {
                    yaml = {
                        validate = true,
                        hover = true,
                        completion = true,
                    },
                },
            })


            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
