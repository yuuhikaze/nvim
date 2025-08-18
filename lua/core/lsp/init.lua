require("neodev").setup({
    library = {
        plugins = { "nvim-dap-ui" }
    }
})
local mason = require("mason")
local mason_lsp_installer = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")
local mason_dap_installer = require("mason-nvim-dap")
local lspconfig = require("lspconfig")

--[[
script file: ~/.config/nvim/init.lua
:p = absolute file path
:h = truncates filename
output: ~/.config/nvim
]]
local script_path = vim.fn.expand("<sfile>:p:h")

-- list: https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
-- configuration: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local servers = {
    "mesonlsp",
    "texlab",
    "basedpyright",
    "clangd",
    "csharp_ls",
    "html",
    "cssls",
    "tailwindcss",
    "ts_ls",
    "svelte",
    "jsonls",
    "taplo",
    "vimls",
    "bashls",
    "lua_ls",
    "marksman", -- `root_markers`: { ".marksman.toml", ".git" }
    "matlab_ls",
    "slint_lsp",
    "glsl_analyzer",
    "pbls",
    "lemminx",
    "phpactor",
    "r_language_server",
    "ols",
    "dockerls",
    "docker_compose_language_service",
    "gopls",
    "golangci_lint_ls",
    "postgres_lsp",
    "hls",
    "zls"
}

-- list: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
-- configuration: https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
local debuggers = {
    "bash",
    "codelldb",
    "javadbg",
    "jdtls",
    "javatest"
}

-- list: https://mason-registry.dev/registry/list
-- configuration: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
local tools = {
    "mypy",
    "pylint",
    "prettier",
    "black",
    "google-java-format",
    "shellcheck",
    "shfmt",
    "clang-format",
    "markdownlint",
    -- "fourmolu",
    -- "pint",
    "pgformatter",
}

mason.setup()
mason_lsp_installer.setup({
    ensure_installed = servers,
    automatic_enable = false,
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

local pylsp_options = vim.tbl_deep_extend("force", default_options, {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    enabled = true,
                    ignore = { 'E501', 'E231' },
                    maxLineLength = 120
                },
                yapf = { enabled = true }
            }
        }
    },
})

local basedpyright_options = vim.tbl_deep_extend("force", default_options, {
    settings = {
        basedpyright = {
            typeCheckingMode = "standard",
        },
    },
})

local lua_ls_options = vim.tbl_deep_extend("force", default_options, {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
        },
    },
})

local html_options = vim.tbl_deep_extend("force", default_options, {
    init_options = {
        provideFormatter = false
    },
})

local clangd_options = vim.tbl_deep_extend("force", default_options, {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" }
})

local r_language_server_options = vim.tbl_deep_extend("force", default_options, {
    cmd = { vim.fn.stdpath("data") .. '/mason/bin/jdtls/r-languageserver' }
})

local server_options = {
    ["lua_ls"] = lua_ls_options,
    -- ["pylsp"] = pylsp_options,
    ["basedpyright"] = basedpyright_options,
    ["html"] = html_options,
    ["clangd"] = clangd_options,
    ["r_language_server"] = r_language_server_options,
}

vim.g.rustaceanvim = {
    server = {
        on_attach = handlers.on_attach,
        capabilities = handlers.capabilities,
        default_settings = {
            ['rust-analyzer'] = {
                cargo = {
                    targetDir = vim.fn.expand('~') .. '/.cargo/rust_analyzer-target'
                },
            },
        },
    }
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

local formatting = null_ls.builtins.formatting
local sources = {
    -- Haskell
    -- null_ls.builtins.formatting.fourmolu.with({ extra_args = { "--indentation=4" } }),
    -- SQL
    null_ls.builtins.formatting.pg_format,
    -- Python
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
    formatting.clang_format.with({ extra_args = { string.format("--style=%s", "{IndentWidth: 4, ColumnLimit: 0, IndentCaseLabels: true}") } }),
    -- HTML
    formatting.prettier.with({
        filetypes = { "html" },
        extra_args = { "--tab-width=4" },
    }),
}

null_ls.setup({ sources = sources })
