require("zen-mode").setup({
    window = {
        backdrop = 1,
        height = 1,
        width = 1,
        options = {
            signcolumn = "no",
            number = false,
            relativenumber = false,
        },
    },
    plugins = {
        gitsigns = { enabled = false },
        tmux = { enabled = false },
        twilight = { enabled = true },
    },
})
