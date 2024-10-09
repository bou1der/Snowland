vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<leader>b<Right>", "<cmd>:wincmd l<CR>", { silent = true })
vim.keymap.set("n", "<leader>b<Left>", "<cmd>:wincmd h<CR>", { silent = true })
vim.keymap.set("n", "<leader>b<Up>", "<cmd>:wincmd k<CR>", { silent = true })
vim.keymap.set("n", "<leader>b<Down>", "<cmd>:wincmd j<CR>", { silent = true })
vim.keymap.set("n", "<leader>bs", "<cmd>:split<CR>", { silent = true })
vim.keymap.set("n", "<leader>bv", "<cmd>:vsplit<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })
vim.keymap.set("n", "<leader>m", "<cmd>:ToggleTerm<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>h", ":CMakeRun<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>H", ":CMakeQuickRun<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", ":CMakeQuickBuild<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>M", ":RunCode<CR>", { noremap = true, silent = true })
