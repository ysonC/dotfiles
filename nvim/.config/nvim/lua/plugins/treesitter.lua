return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.setup()

		treesitter.install({
			"lua",
			"javascript",
			"python",
			"go",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"lua",
				"javascript",
				"python",
				"go",
				"yaml",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
