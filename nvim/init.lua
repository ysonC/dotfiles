vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 10
vim.opt.conceallevel = 2

-- Set Keymaps
vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("i", "qq", "<ESC>")
vim.keymap.set("v", "qq", "<ESC>")
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<C-c>", 'ggVG"+y')
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear highlights" })
vim.keymap.set("n", "<leader>cs", function()
	require("user.additional-schemas").init()
end, { desc = "Choose YAML schema" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Create a command "SetSchema" that calls our script:
vim.api.nvim_create_user_command("SetSchema", function()
	require("user.additional-schemas").init()
end, {})

-- Lazy loading
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
})
