local installed_neodev, neodev = pcall(require, "neodev")
if not installed_neodev then
    return
end

neodev.setup({
    library = {
        plugins = { "nvim-dap-ui" }
    }
})

local installed_mason, mason = pcall(require, "mason")
if not installed_mason then
    return
end

local installed_mason_lspconfig, mason_lsp_installer = pcall(require, "mason-lspconfig")
if not installed_mason_lspconfig then
    return
end

local installed_mason_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
if not installed_mason_tool_installer then
    return
end

local installed_mason_nvim_dap, mason_dap_installer = pcall(require, "mason-nvim-dap")
if not installed_mason_nvim_dap then
    return
end

local installed_lspconfig, lspconfig = pcall(require, "lspconfig")
if not installed_lspconfig then
    return
end

--[[
script file: ~/.config/nvim/init.lua
:p = absolute file path
:h = truncates filename
output: ~/.config/nvim
]]
local script_path = vim.fn.expand("<sfile>:p:h")

-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
local servers = {
    -- "pyright",
    "clangd",
    "csharp_ls",
    "html",
    "cssls",
    "tsserver",
    "jsonls",
    "vimls",
    "bashls",
    "lua_ls",
    "marksman",
    "matlab_ls",
    "rust_analyzer", -- includes formatter (rustfmt)
}

-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
local debuggers = {
    "bash",
    "cppdbg",
}

-- https://mason-registry.dev/registry/list
local tools = {
    -- "mypy",
    "ruff",
    "black",
    "google-java-format",
    "shellcheck",
    "shfmt",
    "clang-format",
    "markdownlint",
}

mason.setup()
mason_lsp_installer.setup({
    ensure_installed = servers,
    automatic_installation = true,
})
mason_dap_installer.setup({
    ensure_installed = debuggers,
    automatic_installation = true,
})
mason_tool_installer.setup {
    ensure_installed = tools,
}

local handlers = require("core.lsp.handlers")

local default_options = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
}

local lua_options = {
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
}

local server_options = {
    ["lua_ls"] = lua_options,
}

for _, server in pairs(servers) do
    local server_option = server_options[server]
    if server_option then
        lspconfig[server].setup(server_option)
    else
        lspconfig[server].setup(default_options)
    end
end

--[[
Henceforth manual setup of servers integrated into `nvim-lspconfig`
    Reason: They are not available for automatic installation in `mason-lspconfig`
]]
lspconfig["gdscript"].setup(default_options)

local installed_null_ls, null_ls = pcall(require, "null-ls")
if not installed_null_ls then
    return
end

local diagnostics = null_ls.builtins.diagnostics
-- local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local sources = {
    -- Python
    -- diagnostics.mypy,
    -- diagnostics.ruff,
    formatting.black,
    -- Java
    formatting.google_java_format.with({ extra_args = { "--aosp" } }),
    -- Shell script
    require("none-ls-shellcheck.diagnostics"),
    require("none-ls-shellcheck.code_actions"),
    formatting.shfmt.with({ extra_args = { "--indent=4", "-ci", "-sr" } }),
    -- Markdown
    formatting.markdownlint.with({ extra_args = { string.format("--config=%s/lua/core/formatters/config/.markdownlint.jsonc", script_path) } }),
    -- CPP
    formatting.clang_format.with({ extra_args = { string.format("--style=%s", "{IndentWidth: 4, ColumnLimit: 300, IndentCaseLabels: true}") } }),
}

null_ls.setup({ sources = sources })
