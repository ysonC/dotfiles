return {
    "mbbill/undotree",
    cmd = "UndotreeToggle",

    config = function()
        -- Optional settings
        vim.g.undotree_WindowLayout = 2 -- split vertically
        vim.g.undotree_ShortIndicators = 1 -- compact display
        vim.g.undotree_SetFocusWhenToggle = 1 -- focus on the window
    end,
}
