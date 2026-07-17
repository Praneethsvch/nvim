--vim.cmd('colorscheme dracula')
require("p.set")
require("p.remap")
require("p.lazy_init")

print('Hello from P')

vim.opt.background = "dark"

vim.cmd('highlight Normal guibg=#000000 ctermbg=0')
vim.cmd('highlight NormalNC guibg=#000000 ctermbg=0')
vim.cmd('highlight SignColumn guibg=#000000 ctermbg=0')
vim.cmd('highlight EndOfBuffer guibg=#000000 ctermbg=0')

-- vim.cmd('highlight Comment guifg=gray ctermfg=darkgray')
vim.cmd('highlight Cursor guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE')

-- Bright block cursor
vim.cmd([[
  highlight Cursor guifg=#000000 guibg=#00FF00
  highlight iCursor guifg=#000000 guibg=#FF00FF
]])

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic message' })

vim.filetype.add({
	extension = {
		overlay = "dts",
	},
})
-- vim.api.nvim_set_keymap('v', '<leader>pc', [[:'<,'>w !~/ollama-comments-gen.sh<CR>]], { noremap = true, silent = true })

vim.g.netrw_list_hide = [[\.DS_Store$]]
