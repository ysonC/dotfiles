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
					vim.fn.executable("go") == 1 and "gopls" or nil,
					"yamlls", --YAML
					"ts_ls", --TypeScript
					"clangd", --C
					"rust_analyzer", --Rust
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				filetypes = { "lua" },
				-- give it obvious roots so it attaches anywhere you have .git or .luarc
				root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
					},
				},
			})
			vim.lsp.enable("lua_ls")

			-- Python Language Server
			vim.lsp.config("pyright", {
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
			vim.lsp.enable("pyright")

			-- TypeScript
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
				on_attach = function(client, bufnr)
					-- disable built-in formatting if you use prettier/eslint
					client.server_capabilities.documentFormattingProvider = false
				end,
				settings = {
					javascript = { suggest = { autoImports = true } },
					typescript = { suggest = { autoImports = true } },
				},
			})
			vim.lsp.enable("ts_ls")

			-- YAML
			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				filetypes = { "yaml", "yml" },
				root_markers = { ".git" },
				settings = { yaml = { validate = true, hover = true, completion = true } },
			})
			vim.lsp.enable("yamlls")

			-- Go (requires Go installed and gopls via Mason)
			if vim.fn.executable("go") == 1 then
				vim.lsp.config("gopls", {
					capabilities = capabilities,
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					root_markers = { "go.work", "go.mod", ".git" },
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = { unusedparams = true },
							staticcheck = true,
						},
					},
				})
				vim.lsp.enable("gopls")
			end
		end,
	},
}
