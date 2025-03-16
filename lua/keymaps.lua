vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<Up>", "", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "", { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.keymap.set("i", "<Up>", "", { noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "", { noremap = true, silent = true })
vim.keymap.set("i", "<Left>", "", { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "", { noremap = true, silent = true })

-- Disable arrow keys in visual mode
vim.keymap.set("v", "<Up>", "", { noremap = true, silent = true })
vim.keymap.set("v", "<Down>", "", { noremap = true, silent = true })
vim.keymap.set("v", "<Left>", "", { noremap = true, silent = true })
vim.keymap.set("v", "<Right>", "", { noremap = true, silent = true })

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<leader>wb", function()
	vim.cmd("bo split")
end, { desc = "Move [Window] to the [B]ottom" })
