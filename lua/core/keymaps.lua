local keyset = vim.keymap.set
local opts = { noremap = true, silent = true }

vim.g.mapleader = "ñ"

-- MODES
-- normal_mode = "n",
-- insert_mode = "i",
-- visual_mode = "v",
-- visual_block_mode = "x",
-- term_mode = "t",
-- command_mode = "c",

-- GENERAL

-- Move cursor within insert mode
keyset("i", "<C-h>", "<Left>", opts)
keyset("i", "<C-l>", "<Right>", opts)
keyset("i", "<C-k>", "<Up>", opts)
keyset("i", "<C-j>", "<Down>", opts)
keyset("i", "<C-b>", "<ESC>^i", opts)
keyset("i", "<C-e>", "<End>", opts)

-- Split mod key
keyset("n", "<C-d>", "<C-w>", opts)

-- Enhanced split navigation
keyset("n", "<C-h>", "<C-w>h", opts)
keyset("n", "<C-l>", "<C-w>l", opts)
keyset("n", "<C-j>", "<C-w>j", opts)
keyset("n", "<C-k>", "<C-w>k", opts)

-- Resize splits with arrows
keyset("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keyset("n", "<C-Right>", ":vertical resize -2<CR>", opts)
keyset("n", "<C-Up>", ":resize +2<CR>", opts)
keyset("n", "<C-Down>", ":resize -2<CR>", opts)

-- Maximize/minimize split
keyset("n", "<Space>te", ":tabedit %<CR>", opts)
keyset("n", "<Space>tc", ":tabclose<CR>", opts)

-- Buffer operations
keyset("n", "<leader>bc", ":%s/\\s\\+$//e<CR>", opts)
keyset("n", "<leader>bd", ":NvimTreeClose<CR>:bdelete!<CR>", opts)
keyset("n", "<leader>bn", ":ene<CR>", opts)
keyset("n", "<leader>bv", ":vnew<CR>", opts)
keyset("n", "<leader>bh", ":new<CR>", opts)
keyset("n", "<leader>bV", ":vert belowright sb ", { noremap = true })
keyset("n", "<leader>bH", ":sbuffer ", { noremap = true })

keyset("n", "<leader>dm", ":vert new | set buftype=nofile | read ++edit # | 0d_ | diffthis | wincmd p | diffthis<CR>", opts) -- :help :DiffOrig
keyset("n", "<leader>dt", ":windo diffthis<CR>", opts)
keyset("n", "<leader>do", ":windo diffoff<CR>", opts)

-- Jump to difference in comparison mode
keyset("", "<leader>dn", "]c", opts)
keyset("", "<leader>dp", "[c", opts)

-- Navigate buffers
keyset("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keyset("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

-- Save buffers
keyset("i", "<C-s>", "<C-o>:w<CR>", opts)
keyset("i", "<C-a>", "<C-o>:wa<CR>", opts)
keyset("n", "<C-s>", ":w<CR>", opts)
keyset("n", "<C-a>", ":wa<CR>", opts)

-- Toggle text wrap
keyset("n", "<leader>w", ":set wrap!<CR>", opts)

-- Toggle text fold
keyset("n", "<C-Space>", "za", opts)

-- Reset highlighting
keyset("n", "<leader><Space>", ":noh<CR>", opts)

-- Show full path
keyset("n", "<leader>p", "1<C-G>", opts)

-- Count words
keyset("", "<leader>cw", "g<C-G>", opts)

-- Find and replace
keyset("n", "<Space>f", ":SearchBoxMatchAll clear_matches=false<CR>", {noremap = true})
keyset("v", "<Space>f", ":SearchBoxMatchAll clear_matches=false visual_mode=true<CR>", {noremap = true})
keyset("n", "<Space>r", ":%s @@@g<Left><Left><Left>", {noremap = true})
keyset("v", "<Space>r", ":s @\\%V@@g<Left><Left><Left>", {noremap = true})
keyset("n", "<Space>R", ":%s @@@g<Left><Left>", {noremap = true})
keyset("v", "<Space>R", ":s @\\%V@@g<Left><Left>", {noremap = true})

-- Jump to character or word
keyset("", "s", ":HopChar2<cr>", opts)
keyset("", "S", ":HopWord<cr>", opts)

-- Enable ctrl+supr
keyset("i", "<C-Del>", "X<Esc>ce", opts)

-- Close neovim
keyset("n", "<C-w>", ":qa<CR>", opts)
keyset("n", "<C-x>", ":qa!<CR>", opts)

-- Indentation
keyset("v", "<Tab>", ">gv", opts)
keyset("v", "<S-Tab>", "<gv", opts)
keyset("n", "<Tab>", "V>gv<Esc>", opts)
keyset("n", "<S-Tab>", "V<gv<Esc>", opts)
keyset("n", "<leader><Tab>", "gg=G''", opts)
keyset("i", "<CR>", "<CR>x<BS>", opts)
keyset("n", "o", "ox<BS>", opts)
keyset("n", "O", "Ox<BS>", opts)

-- Move text up and down
keyset("n", "<S-k>", ":m .-2<CR>==", opts)
keyset("n", "<S-j>", ":m .+1<CR>==", opts)

-- Join current line with next line
keyset("n", "<leader>j", "J", opts)

-- Set alternate keymaps
keyset("n", "<Space>lk", ":set keymap=kana<CR>", opts)
keyset("n", "<Space>lr", ":set keymap=russian-jcuken<CR>", opts)

-- TODO
keyset("n", "<leader>t", ":1M/^((?!ø|---|^\\w.+).)*$<CR>", {noremap = true})

-- Convenience
keyset("n", "0", "^", opts)
keyset("v", "0", "^", opts)
keyset("n", "=", "0", opts)
keyset("v", "=", "0", opts)
keyset("n", "#", "*", opts)
keyset("v", "#", "*", opts)
keyset("n", "<leader>y", "ggvG$y", opts)

-- PLUGIN SPECIFIC
-- Display keybindings [cheatsheet]
keyset("n", "?", ":Cheatsheet<CR>", opts)

-- Fuzzy file manager [Telescope]
keyset("n", "<leader>ff", ":Telescope find_files hidden=true<CR>", opts) -- hidden=true → Shows hidden files
keyset("n", "<leader>fo", ":Telescope oldfiles<CR>", opts)
keyset("n", "<leader>fw", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
keyset("n", "<leader>fz", ":Telescope zoxide list<CR>", opts)

-- Cut text [vim-cutlass]
keyset("n", "m", "d", opts)
keyset("x", "m", "d", opts)
keyset("n", "mm", "dd", opts)
keyset("n", "M", "D", opts)

-- File tree [nvim-tree]
keyset("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Toggle zen mode [zen-mode]
keyset("n", "<leader>z", ":ZenMode<CR>", opts)

-- Toggle autochdir [rooter]
keyset("n", "<C-p>", ":RooterToggle<CR>", { noremap = true })

-- Show ctags [Tagbar]
keyset("n", "<C-t>", ":Tagbar<CR>", opts)

-- [luasnip]

keyset({"i", "s"}, "<C-S-l>", "<CMD>lua require('luasnip').jump(1)<CR>", opts)
keyset({"i", "s"}, "<C-S-h>", "<CMD>lua require('luasnip').jump(-1)<CR>", opts)

-- [codeium]
keyset("n", "<leader>ct", ":CodeiumToggle<CR>", opts)
keyset("i", "<C-Space>", "<CMD>call codeium#Complete()<CR>", opts)
keyset('i', '<C-Tab>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
keyset("i", "<C-S-j>", "<CMD>call codeium#CycleCompletions(1)<CR>", opts)
keyset("i", "<C-S-k>", "<CMD>call codeium#CycleCompletions(-1)<CR>", opts)
keyset("i", "<C-c>", "<CMD>call codeium#Clear()<CR>", opts)

-- [nvim-dap]
keyset("n", "<Space>di", ":lua require('core.debugger')<CR>", opts) -- Initialize dap
keyset("n", "<Space>du", ":lua require('dapui').toggle()<CR>", opts)
keyset("n", "<Space>de", ":lua require('dapui').eval([[]])<Left><Left><Left>", { noremap = true }) -- Evaluate expression 
keyset("n", "<Space>dr", ":DapContinue<CR>", opts)
keyset("n", "<Space>db", ":DapToggleBreakpoint<CR>", opts)
keyset("n", "<Space>dj", ":DapStepInto<CR>", opts)
keyset("n", "<Space>dk", ":DapStepOut<CR>", opts)
keyset("n", "<Space>dl", ":DapStepOver<CR>", opts)
keyset("n", "<Space>dt", ":DapTerminate<CR>", opts)
keyset("n", "<Space>df", ":lua require('telescope').extensions.dap.list_breakpoints{}<CR>", opts)
keyset("n", "<Space>dc", ":lua require('telescope').extensions.dap.commands{}<CR>", opts)

-- Display local history [undotree]
keyset("n", "<C-u>", ":UndotreeToggle<CR>", opts)

-- Undo mappings
vim.api.nvim_del_keymap('n', '<C-w>d') -- Show diagnostics under the cursor
vim.api.nvim_del_keymap('n', '<C-w><C-d>') -- Show diagnostics under the cursor
