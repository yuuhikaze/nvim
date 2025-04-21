local M = {}

local installed_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not installed_cmp_nvim_lsp then
    return
end

local keymaps = function(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", ":lua vim.diagnostic.goto_next()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", ":lua vim.diagnostic.goto_prev()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", ":Telescope lsp_definitions<CR>", opts)                        -- jumps to the definition of the symbol under the cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":Telescope lsp_references<CR>", opts)                         -- lists all the references to the symbl under the cursor in the quickfix window
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":Telescope lsp_implementations<CR>", opts)                    -- lists all the implementations for the symbol under the cursor in the quickfix window
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", opts)            -- selects a code action available at the current cursor position
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lr", ":lua vim.lsp.buf.rename()<CR>", opts)                 -- renaname old_fname to new_fname
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts) -- formats the current buffer
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<CR>", opts) -- formats the current buffer
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opts)                  -- shows documentation under cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ls", ":lua vim.lsp.buf.signature_help()<CR>", opts)         -- shows signature under cursor
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    keymaps(bufnr)
end

M.capabilities = cmp_nvim_lsp.default_capabilities()
M.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

return M
