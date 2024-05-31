local installed, treesitter = pcall(require, "nvim-treesitter.configs")
if not installed then
    return
end

treesitter.setup {
    -- A list of parser names, or "all"
    ensure_installed = {
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
        "markdown_inline",
        "vim",
        "bash",
        "lua",
        "gdscript",
        -- "gdresource",
        "mermaid",
        "latex",
        "rust",
    },
    highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
}
