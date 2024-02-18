--vim.cmd('colorscheme dracula')
require("p.set")
require("p.remap")
require("p.lazy_init")

print('Hello from P')

vim.cmd('highlight Normal guibg=black ctermbg=black')
vim.cmd('highlight Comment guifg=gray ctermfg=darkgray')
vim.cmd('highlight Cursor guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE')



