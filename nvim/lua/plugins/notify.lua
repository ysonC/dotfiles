return {
	"rcarriga/nvim-notify",
	config = function()
		require("notify").setup({
			render = "wrapped-compact",
			stages = "fade_in_slide_out",
			timeout = 2000,
			background_colour = "#000000",
		})
		vim.notify = require("notify")
	end,
}
