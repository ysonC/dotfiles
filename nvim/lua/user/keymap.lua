local map = vim.keymap.set

-- Basic
map("n", "<leader>q", ":q<CR>")
map("i", "qq", "<ESC>")
map("v", "qq", "<ESC>")
map("n", "<leader>y", '"+y')
map("n", "<leader>w", ":w<CR>")
map("n", "<C-c>", 'ggVG"+y')
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { silent = true })
map("n", "<A-n>", "<cmd>Neotree left<CR>", { silent = true })
map("n", "<A-up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-down>", ":m .+1<CR>", { desc = "Move line down" })

-- LSP
map("n", "<leader>cs", function()
	require("user.additional-schemas").init()
end, { desc = "Choose YAML schema" })
map("n", "<leader>r", vim.lsp.buf.rename, {})
map("n", "K", vim.lsp.buf.hover, {})
map("n", "gd", vim.lsp.buf.definition, {})
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
map("n", "<leader>er", vim.diagnostic.goto_next, {})
map("n", "<leader>fa", vim.lsp.buf.references, {})

-- None-ls
map("n", "<leader>ff", vim.lsp.buf.format, {})

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<C-p>", builtin.find_files, {})
map("n", "<leader>fg", builtin.live_grep, {})

-- Tab
map("n", "<TAB>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
	vim.api.nvim_exec_autocmds("User", { pattern = "HarpoonChanged" })
end, { desc = "Harpoon: Add file" })
vim.keymap.set("n", "<leader>m", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
for i = 1, 5 do
	vim.keymap.set("n", "<leader>" .. i, function()
		harpoon:list():select(i)
	end, { desc = "Harpoon: Go to file " .. i })
end

-- Undotree
map("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Toggle UndoTree" })

-- Gitsigns
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
