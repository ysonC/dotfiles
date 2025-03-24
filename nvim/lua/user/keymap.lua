local map = vim.keymap.set

-- Set Keymaps
map("n", "<leader>q", ":q<CR>")
map("i", "qq", "<ESC>")
map("v", "qq", "<ESC>")
map("n", "<leader>y", '"+y')
map("n", "<leader>w", ":w<CR>")
map("n", "<C-c>", 'ggVG"+y')
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
map("n", "<leader>cs", function()
    require("user.additional-schemas").init()
end, { desc = "Choose YAML schema" })
map("n", "<C-n>", "<cmd>Neotree toggle<CR>", { silent = true })

map("n", "<A-up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-down>", ":m .+1<CR>", { desc = "Move line down" })

-- Set tab Keymaps
map("n", "<TAB>", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
