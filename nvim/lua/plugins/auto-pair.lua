return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    depends = "hrsh7th/nvim-cmp",

    config = function()
        local autopairs = require("nvim-autopairs")
        require("nvim-autopairs").setup()
        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string" }, -- it will not add pair on that treesitter node
                javascript = { "template_string" },
                java = false, -- don't check treesitter on java
            },
        })
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
