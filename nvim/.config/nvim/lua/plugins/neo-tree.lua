return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		window = {
			width = 30,
			-- auto_expand_width = true,
		},
		filesystem = {
			filtered_items = {
				visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		},
		source_selector = {
			winbar = true,
		},
	},
	---@diagnostic disable-next-line: unused-local
	config = function(__, opts)
		require("neo-tree").setup(opts)
	end,
}
