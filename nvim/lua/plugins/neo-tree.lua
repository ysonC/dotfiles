return{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
                hide_dotfiles = false,
                hide_gitignored = true,
            },
        },
    },
    config = function(__,opts)
        require("neo-tree").setup(opts)
        vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', {})
    end
}
