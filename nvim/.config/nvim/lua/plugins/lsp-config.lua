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
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
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
			-- check for go bin first
			if vim.fn.executable("go") == 1 then
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
			end

			-- C / C++ Language Server
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd" }, -- optional if clangd is in PATH
				filetypes = { "c", "cpp", "objc", "objcpp" },
				root_dir = lspconfig.util.root_pattern(
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					".git"
				),
			})

			-- Rust setup
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				filetypes = { "rust" },
				root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json", ".git"),
				settings = {
					["rust-analyzer"] = {
						cargo = { allFeatures = true },
						checkOnSave = true,
					},
				},
			})
		end,
	},
}
