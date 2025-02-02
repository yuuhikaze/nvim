local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local icons = require "core.icons"

local kind_icons = icons.kind

vim.g.cmp_active = true

cmp.setup {
    enabled = function()
        local buftype = vim.api.nvim_buf_get_option(0, "buftype")
        if buftype == "prompt" then
            return false
        end
        return vim.g.cmp_active
    end,
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ["<C-S-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-S-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<C-S-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-c>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm { select = false },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            -- elseif luasnip.jumpable(1) then
                -- luasnip.jump(1)
            -- elseif luasnip.expand_or_jumpable() then
            --     luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                -- cmp.complete()
                fallback()
            else
                fallback()
            end
        end, {
                "i",
                "s",
            }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            -- elseif luasnip.jumpable(-1) then
            --     luasnip.jump(-1)
            else
                fallback()
            end
        end, {
                "i",
                "s",
            }),
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = kind_icons[vim_item.kind]
            if entry.source.name == "nvim_lsp_signature_help" then
                vim_item.kind = '🐼'
            end
            -- if entry.source.name == "cmp_tabnine" then
            --     vim_item.kind = icons.misc.Robot
            --     vim_item.kind_hl_group = "CmpItemKindTabnine"
            -- end
            -- NOTE: order matters
            vim_item.menu = ({
                nvim_lsp = "",
                luasnip = "",
                path = "",
                buffer = "",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp_signature_help' },
        {
            name = "nvim_lsp",
            filter = function(entry, ctx)
                local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
                if kind == "Snippet" and ctx.prev_context.filetype == "java" then
                    return true
                end

                if kind == "Text" then
                    return true
                end
            end,
        },
        { name = "luasnip" },
        { name = "path" },
        -- { name = "cmp_tabnine" },
        {
            name = "buffer",
            filter = function(entry, ctx)
                if not contains(buffer_fts, ctx.prev_context.filetype) then
                    return true
                end
            end,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Background,floatBorder:TelescopeBorder,CursorLine:TelescopeSelection,Search:None"
        }),
        documentation = cmp.config.window.bordered({
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "Normal:Background,floatBorder:TelescopeBorder,CursorLine:TelescopeSelection,Search:None"
        })
    },
    experimental = {
        ghost_text = true,
    },
}
