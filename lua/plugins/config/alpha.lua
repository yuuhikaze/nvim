local dashboard = require("alpha.themes.dashboard")

-- Set header.
dashboard.section.header.val = {
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}

-- Set menu.
dashboard.section.buttons.val = {
    dashboard.button("o", "  Recently opened files", ":Telescope oldfiles<CR>"),
    dashboard.button("e", "  New file", ":enew<CR>"),
    dashboard.button("f", "  Find files", ":Telescope find_files hidden=true<CR>"),
    dashboard.button("w", "  Find text", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>"),
    dashboard.button("s", "󰆓  Find session", ":SessionManager load_session<CR>"),
    dashboard.button("b", "  Bookmarks", ":Telescope marks<CR>"),
    dashboard.button("i", "  Settings", ":e ~/.config/nvim/init.lua<CR>"),
}

-- Send options to alpha.
require("alpha").setup(dashboard.opts)
