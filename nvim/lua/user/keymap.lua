local map = vim.keymap.set

-- Basic
map("n", "<leader>q", ":q<CR>")
map("i", "qq", "<ESC>")
map("v", "qq", "<ESC>")
map("n", "+", "<C-d>zz")
map("n", "_", "<C-u>zz")

map("n", "<leader>y", '"+y')
map("n", "<leader>w", ":w<CR>")
map("n", "<C-c>", 'ggVG"+y')
map("n", "<leader>pp", "yyp")
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { silent = true })
map("n", "<A-n>", "<cmd>Neotree left<CR>", { silent = true })
map("n", "<A-up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-down>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<leader>o", "o<Esc>")

-- LSP
map("n", "<leader>cs", function()
	require("user.additional-schemas").init()
end, { desc = "Choose YAML schema" })
map("n", "<leader>r", vim.lsp.buf.rename, {})
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gd", vim.lsp.buf.definition, {})
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
map("n", "er", vim.diagnostic.goto_next, {})

-- None-ls
map("n", "<leader>ff", vim.lsp.buf.format, {})

-- Telescope
local telescope = require("telescope.builtin")
map("n", "<C-p>", telescope.find_files, {})
map("n", "<A-p>", function()
	telescope.find_files({
		hidden = true,
		no_ignore = true,
		no_ignore_parent = true,
	})
end, {})
map("n", "<leader>fg", telescope.live_grep, {})
map("n", "<leader>fs", telescope.lsp_document_symbols, {})
map("n", "<leader>fa", telescope.lsp_references, {})
map("n", "<leader>fe", telescope.diagnostics, {})
map("n", "<leader>git", telescope.git_status, {})

-- Harpoon
local harpoon = require("harpoon")
map("n", "<leader>a", function()
	harpoon:list():add()
	vim.api.nvim_exec_autocmds("User", { pattern = "HarpoonChanged" })
end, { desc = "Harpoon: Add file" })
map("n", "<leader>m", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
for i = 1, 5 do
	map("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon: Go to file " .. i })
end

-- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- Gitsigns
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
