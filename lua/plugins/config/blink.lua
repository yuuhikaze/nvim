local icons = require "core.icons"
local kind_icons = icons.kind

vim.g.cmp_active = true

require('blink.cmp').setup({
    keymap = {
        preset = 'default',
        ['<C-S-k>'] = { 'select_prev', 'fallback' },
        ['<C-S-j>'] = { 'select_next', 'fallback' },
        ['<C-S-Space>'] = { 'show', 'fallback' },
        ['<C-c>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal',
    },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
            },
            snippets = {
                name = 'Snippets',
                module = 'blink.cmp.sources.snippets',
                opts = {
                    friendly_snippets = true,
                    search_paths = { vim.fn.stdpath("data") .. "/lazy/flutter-snippets" },
                },
            },
        },
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        menu = {
            border = 'rounded',
            winhighlight = 'Normal:Background,FloatBorder:TelescopeBorder,CursorLine:TelescopeSelection,Search:None',
            draw = {
                columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
                components = {
                    kind_icon = {
                        text = function(ctx)
                            -- 🐼 THE PANDA! Show panda for function signatures
                            local kind_name = ctx.kind
                            if kind_name == 'Function' or kind_name == 'Method' then
                                -- Check if it's a signature-like item
                                if ctx.item and ctx.item.labelDetails then
                                    return '🐼'
                                end
                            end
                            return kind_icons[ctx.kind] or ctx.kind_icon or ''
                        end,
                    },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = 'rounded',
                winhighlight = 'Normal:Background,FloatBorder:TelescopeBorder,CursorLine:TelescopeSelection,Search:None',
            },
        },
        ghost_text = {
            enabled = true,
        },
    },

    signature = {
        enabled = true,
        window = {
            border = 'rounded',
        },
    },

    snippets = {
        expand = function(snippet)
            require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
            if filter and filter.direction then
                return require('luasnip').jumpable(filter.direction)
            end
            return require('luasnip').in_snippet()
        end,
        jump = function(direction)
            require('luasnip').jump(direction)
        end,
    },
})
