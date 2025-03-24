return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = {
			"ThePrimeagen/harpoon",
		},
		opts = function()
			return {
				options = {
					mode = "buffers",
					separator_style = "slant",
					diagnostics = "nvim_lsp",
					always_show_bufferline = false,

					-- Only show Harpoon-marked buffers
					custom_filter = function(bufnr)
						local ok, harpoon = pcall(require, "harpoon")
						if not ok then
							return false
						end

						local list = harpoon:list()
						local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p")

						for _, item in ipairs(list.items) do
							if vim.fn.fnamemodify(item.value, ":p") == bufname then
								return true
							end
						end
						return false
					end,

					-- Show Harpoon index as buffer number
					numbers = function(opts)
						local ok, harpoon = pcall(require, "harpoon")
						if not ok then
							return ""
						end

						local list = harpoon:list()
						local bufname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(opts.id), ":p")

						for i, item in ipairs(list.items) do
							if vim.fn.fnamemodify(item.value, ":p") == bufname then
								return tostring(i)
							end
						end

						return ""
					end,

					-- Sort buffers according to Harpoon order
					sort_by = function(buffer_a, buffer_b)
						local ok, harpoon = pcall(require, "harpoon")
						if not ok then
							return false
						end

						local list = harpoon:list()
						local name_a = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer_a.id), ":p")
						local name_b = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer_b.id), ":p")

						local index_a, index_b = nil, nil
						for i, item in ipairs(list.items) do
							local path = vim.fn.fnamemodify(item.value, ":p")
							if path == name_a then
								index_a = i
							end
							if path == name_b then
								index_b = i
							end
						end

						-- fallback to default sort if either not found
						index_a = index_a or 999
						index_b = index_b or 999

						return index_a < index_b
					end,
				},
			}
		end,
	},
}
