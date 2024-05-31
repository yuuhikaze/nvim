vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_foreground = 'mix'
local colorscheme = "gruvbox-material"

local installed, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not installed then
    return
end
