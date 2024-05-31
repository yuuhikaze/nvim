local status_ok, comment = pcall(require, "Comment")
if not status_ok then
    return
end

local leader = vim.g.mapleader

comment.setup {
    padding = true,
    sticky = true,
    ignore = nil,
    toggler = {
        line = leader .. "cs",
        block = leader .. "cm",
    },
    opleader = {
        line = leader .. "cs",
        block = leader .. "cm",
    },
    mappings = {
        basic = true,
        extra = true,
        extended = false,
    },
    pre_hook = nil,
    post_hook = nil,
}
