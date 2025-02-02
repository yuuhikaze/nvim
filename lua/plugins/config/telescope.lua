local telescope = require("telescope")
local actions = require('telescope.actions')
local transform_mod = require("telescope.actions.mt").transform_mod

local multiopen = function(prompt_bufnr, open_cmd)
    local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
    local multi = picker:get_multi_selection()
    if not vim.tbl_isempty(multi) then
        require('telescope.actions').close(prompt_bufnr)
        for _, j in pairs(multi) do
            if j.path ~= nil then
                if j.lnum ~= nil then
                    vim.cmd(string.format("%s +%s %s", open_cmd, j.lnum, j.path))
                else
                    vim.cmd(string.format("%s %s", open_cmd, j.path))
                end
            end
        end
    else
        require('telescope.actions').select_default(prompt_bufnr)
    end
end

local custom_actions = transform_mod({
    multi_selection_open_default = function(prompt_bufnr)
        multiopen(prompt_bufnr, "edit")
    end,
    multi_selection_open_horizontal = function(prompt_bufnr)
        multiopen(prompt_bufnr, "split")
    end,
    multi_selection_open_vertical = function(prompt_bufnr)
        multiopen(prompt_bufnr, "vsplit")
    end,
})

local options = {
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-J>"] = actions.move_selection_next,
                ["<C-K>"] = actions.move_selection_previous,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<S-CR>"] = actions.select_default,
                ["<CR>"] = custom_actions.multi_selection_open_default,
                ["<C-V>"] = custom_actions.multi_selection_open_vertical,
                ["<C-H>"] = custom_actions.multi_selection_open_horizontal,
                ["<C-DOWN>"] = actions.cycle_history_next,
                ["<C-UP>"] = actions.cycle_history_prev,
            },
        },
        prompt_prefix = "     ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.80,
            height = 0.85,
            preview_cutoff = 120,
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
    },
    extensions = {
        live_grep_args = {
            auto_quoting = false,
            mappings = {
                i = {
                    ["<C-q>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " -" }),
                },
            },
        },
    }
}

telescope.setup(options)

-- Load extensions.
local extensions = {
    "ui-select",
    "zoxide",
    "live_grep_args",
    "sessions"
}

pcall(function()
    for _, v in ipairs(extensions) do
        telescope.load_extension(v)
    end
end)

--[[ Credits
https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-2142669167
https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1220846367 ]]
