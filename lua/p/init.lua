--vim.cmd('colorscheme gruvbox')
--vim.g.gruvbox_contrast_dark = 'hard'
--vim.cmd('colorscheme nord')
--vim.cmd('colorscheme tomorrow-night')
--vim.cmd('colorscheme dracula')
require("p.set")
require("p.remap")
print('Hello from P')
vim.cmd('highlight Normal guibg=black ctermbg=black')
vim.cmd('highlight Comment guifg=gray ctermfg=darkgray')
vim.cmd('highlight Cursor guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE')

