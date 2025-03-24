return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", --Lua
					"pyright", --Python
					"gopls", --Go
					"yamlls", --YAML
					"ts_ls", --TypeScript
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Python Language Server
			lspconfig.pyright.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					pyright = { autoImportCompletion = true },
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "off",
						},
					},
				},
			})

			-- TypeScript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormatingProvider = false
				end,
				settings = {
					javascript = {
						suggest = {
							autoImports = true,
						},
					},
					typescript = {
						suggest = {
							autoImports = true,
						},
					},
				},
			})

			-- YAML
			lspconfig.yamlls.setup({
				capabilities = capabilities,
				settings = {
					yaml = {
						validate = true,
						hover = true,
						completion = true,
					},
				},
			})

			-- gopls
			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
					},
				},
			})
		end,
	},
}
