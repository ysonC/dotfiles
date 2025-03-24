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

-- None-ls
map("n", "<leader>ff", vim.lsp.buf.format, {})

-- Telescope
local builtin = require("telescope.builtin")
map("n", "<C-p>", builtin.find_files, {})
map("n", "<leader>fg", builtin.live_grep, {})

-- Tab
map("n", "<TAB>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })

-- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
map("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add file" })
map("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon: Toggle quick menu" })
map("n", "<leader>hh", "<cmd>Telescope harpoon marks<CR>", { desc = "Harpoon: Toggle quick menu" })
map("n", "<leader>1", function()
	ui.nav_file(1)
end, { desc = "Harpoon: File 1" })
map("n", "<leader>2", function()
	ui.nav_file(2)
end, { desc = "Harpoon: File 2" })
map("n", "<leader>3", function()
	ui.nav_file(3)
end, { desc = "Harpoon: File 3" })
map("n", "<leader>4", function()
	ui.nav_file(4)
end, { desc = "Harpoon: File 4" })
map("n", "<leader>hn", ui.nav_next, { desc = "Harpoon: Next file" })
map("n", "<leader>hp", ui.nav_prev, { desc = "Harpoon: Prev file" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Gitsigns
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
