return {
    {
        "BourbonBidet/Barpoon",
        dependencies = {
            {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("harpoon").setup({
                global_settings = {
                    save_on_toggle = false,
                    save_on_change = true,
                    enter_on_sendcmd = false,
                    tmux_autoclose_windows = false,
                    excluded_filetypes = { "harpoon" },
                    mark_branch = false,
                    tabline = false,
                },
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 4,
                },
            })

            -- Keymaps
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add file" })
            vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon: Toggle quick menu" })
            vim.keymap.set("n", "<leader>1", function()
                ui.nav_file(1)
            end, { desc = "Harpoon: File 1" })
            vim.keymap.set("n", "<leader>2", function()
                ui.nav_file(2)
            end, { desc = "Harpoon: File 2" })
            vim.keymap.set("n", "<leader>3", function()
                ui.nav_file(3)
            end, { desc = "Harpoon: File 3" })
            vim.keymap.set("n", "<leader>4", function()
                ui.nav_file(4)
            end, { desc = "Harpoon: File 4" })

            vim.keymap.set("n", "<leader>hn", ui.nav_next, { desc = "Harpoon: Next file" })
            vim.keymap.set("n", "<leader>hp", ui.nav_prev, { desc = "Harpoon: Prev file" })
        end,
    },
}
