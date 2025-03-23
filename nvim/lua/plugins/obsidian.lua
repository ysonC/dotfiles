return {
	"epwalsh/obsidian.nvim",
	lazy = true, -- Load only when needed
	event = { "BufReadPre", "BufNewFile" }, -- Load when opening Markdown files
	config = function()
		-- Function to detect if we are inside an Obsidian vault
		local function is_obsidian_vault()
			local cwd = vim.fn.expand("%:p:h") -- Get current file directory
			while cwd ~= "/" do
				if vim.fn.isdirectory(cwd .. "/.obsidian") == 1 then
					return cwd -- Found vault, return path
				end
				cwd = vim.fn.fnamemodify(cwd, ":h") -- Go one level up
			end
			return nil
		end

		-- Check if we are in a vault
		local vault_path = is_obsidian_vault()
		if vault_path then
			require("obsidian").setup({
				dir = vault_path, -- Set detected vault as working directory
				completion = { nvim_cmp = true },
				note_frontmatter_func = function(note)
					return {
						-- tags = note.tags or {},
						-- creation_date = os.date("%Y-%m-%d"),
					}
				end,
			})
		end
	end,
}
