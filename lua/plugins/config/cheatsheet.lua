local installed, cheatsheet = pcall(require, "cheatsheet")
if not installed then
	return
end

cheatsheet.setup({
	-- bundled_cheatsheets = {
	-- 	enabled = { 'nerd-fonts' },
	-- 	disabled = {},
	-- },
	bundled_cheatsheets = false,
    bundled_plugin_cheatsheets = false,
    include_only_installed_plugins = false,

    -- Key mappings bound inside the telescope window
    telescope_mappings = {
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
    }
})
