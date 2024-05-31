local installed, bufferline = pcall(require, "bufferline")
if not installed then
    return
end

bufferline.setup{
    options = {
        numbers = "none",
        indicator = "",
        buffer_close_icon = "✕",
        modified_icon = "⦿",
        close_icon = "✖",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 20,
        enforce_regular_tabs = true,
        diagnostics = false,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = false,
        persist_buffer_sort = true,
        separator_style = "thin",
        always_show_bufferline = true,
        offsets = { { filetype = "NvimTree", text = "" } },
    },
    highlights = {
        fill = {
            bg = '#1d1d1d',
        },
        tab = {
            bg = '#1d1d1d',
        },
        tab_close = {
            bg = '#1d1d1d',
        },
        background = {
            bg = '#1d1d1d',
        },
        buffer_visible = {
            bg = '#1d1d1d',
        },
        close_button = {
            bg = '#1d1d1d',
        },
        close_button_visible = {
            bg = '#1d1d1d',
        },
        separator = {
            bg = '#1d1d1d',
        },
        separator_selected = {
            bg = '#1d1d1d',
        },
        modified = {
            bg = '#1d1d1d',
        },
        modified_visible = {
            bg = '#1d1d1d',
        },
    }
}
