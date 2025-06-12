return {
    "nvim-lualine/lualine.nvim",
    depends = "nvim-tree/nvim-web-devicons",
    config = function()
        local lualine = require("lualine")
        local colors = {
            blue = "#65d1ff",
            green = "#3effdc",
            violet = "#ff61ef",
            yellow = "#ffda7b",
            red = "#ff4a4a",
            fg = "#c3ccdc",
            bg = "#112638",
            inactive = "#2c3043",
        }

        local my_lualine_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            insert = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            visual = {
                a = { fg = colors.bg, bg = colors.violet, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            replace = {
                a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            command = {
                a = { fg = colors.bg, bg = colors.red, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
            inactive = {
                a = { fg = colors.inactive, bg = colors.bg, gui = "bold" },
                b = { fg = colors.inactive, bg = colors.bg },
                c = { fg = colors.inactive, bg = colors.bg },
            },
        }

        lualine.setup({
            options = {
                theme = my_lualine_theme,
            },
        })
    end,
}
