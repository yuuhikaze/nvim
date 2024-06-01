require("zen-mode").setup({
    window = {
        backdrop = 1,
        height = 1,
        width = 1,
        options = {
            signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
        },
    },
    plugins = {
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false },
        twilight = { enabled = true },
    },
})
