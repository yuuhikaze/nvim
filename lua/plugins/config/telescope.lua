local installed_telescope, telescope = pcall(require, "telescope")
if not installed_telescope then
    return
end

local installed_telescope_live_grep_args_actions, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not installed_telescope_live_grep_args_actions then
    return
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local multiopen = function(prompt_bufnr, open_cmd)
    local picker = action_state.get_current_picker(prompt_bufnr)
    local num_selections = #picker:get_multi_selection()
    if not num_selections or num_selections <= 1 then
        actions.add_selection(prompt_bufnr)
    end
    actions.send_selected_to_qflist(prompt_bufnr)

    local results = vim.fn.getqflist()

    for _, result in ipairs(results) do
        local current_file = vim.fn.bufname()
        local next_file = vim.fn.bufname(result.bufnr)

        if current_file == "" then
            vim.api.nvim_command("edit" .. " " .. next_file)
        else
            vim.api.nvim_command(open_cmd .. " " .. next_file)
        end
    end

    vim.api.nvim_command("cd .")
end

local function multi_selection_open(prompt_bufnr)
    multiopen(prompt_bufnr, "edit")
end

local function multi_selection_open_vsplit(prompt_bufnr)
    multiopen(prompt_bufnr, "vsplit")
end

local function multi_selection_open_split(prompt_bufnr)
    multiopen(prompt_bufnr, "split")
end

local function multi_selection_open_tab(prompt_bufnr)
    multiopen(prompt_bufnr, "tabedit")
end

local options = {
    defaults = {
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
                ["<C-J>"] = actions.move_selection_next,
                ["<C-K>"] = actions.move_selection_previous,
                ["<leader><TAB>"] = actions.toggle_selection,
                ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
                ["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
                ["<S-CR>"] = actions.select_default,
                ["<CR>"] = multi_selection_open,
                ["<C-V>"] = multi_selection_open_vsplit,
                ["<C-H>"] = multi_selection_open_split,
                ["<C-T>"] = multi_selection_open_tab,
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
                    ["<C-q>"] = lga_actions.quote_prompt({ postfix = " -" }),
                },
            },
        },
        fzf = {
            fuzzy = false, -- Perform exact matching
        }
    }
}

-- Check for any override
telescope.setup(options)

-- Load extensions
local extensions = { "fzf", "ui-select", "zoxide", "live_grep_args" }

pcall(function()
    for k,v in ipairs(extensions) do
        telescope.load_extension(v)
    end
end)
