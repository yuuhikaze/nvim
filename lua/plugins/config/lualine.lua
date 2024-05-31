local installed, lualine = pcall(require, "lualine")
if not installed then
    return
end

local colors = {
    red = '#ca1243',
    grey = '#a0a1a7',
    black = '#383a42',
    white = '#f3f3f3',
    light_green = '#83a598',
    orange = '#fe8019',
    green = '#8ec07c',
}

local function process_sections(sections)
    for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
            table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
        end
        for id, comp in ipairs(section) do
            if type(comp) ~= 'table' then
                comp = { comp }
                section[id] = comp
            end
            comp.separator = left and { right = '' } or { left = '' }
        end
    end
    return sections
end

lualine.setup {
    options = {
        theme = 'auto',
        disabled_filetypes = { 'NvimTree', 'vim-plug' },
    },
    sections = process_sections {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filetype' },
        lualine_c = { 'fileformat' },
        lualine_x = { '%3{codeium#GetStatusString()}', 'branch' },
        lualine_y = { 'encoding' },
        lualine_z = {
            { 'progress', separator = { right = '' }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { 'filetype' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'progress' },
    },
    tabline = {},
    extensions = {},
}
