local parsers = {
    "python",
    "c",
    "cpp",
    "c_sharp",
    "java",
    "html",
    "css",
    "javascript",
    "json",
    "markdown",
    -- "markdown_inline",
    "vim",
    "bash",
    "lua",
    "gdscript",
    "mermaid",
    "latex",
    "rust",
}

require("nvim-treesitter.configs").setup {
    ensure_installed = parsers,
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
}
