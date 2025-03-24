return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        config = function()
            local harpoon = require("harpoon")

            -- Optional keymaps (customize as needed)
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

            -- basic telescope configuration
            local conf = require("telescope.config").values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers")
                    .new({}, {
                        prompt_title = "Harpoon",
                        finder = require("telescope.finders").new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end
            vim.keymap.set("n", "<leader>hh", function()
                toggle_telescope(harpoon:list())
            end, { desc = "Harpoon: Toggle quick menu" })
        end,
    },
}
