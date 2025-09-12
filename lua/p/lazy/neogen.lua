return {
	"danymat/neogen",
	config = true,
	-- Uncomment next line if you want to follow only stable versions
	version = "*",

	-- config = function()
	-- 	require('neogen').generate()
	-- 	local opts = { noremap = true, silent = true }
	-- 	vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>",
	-- 		opts)

	-- 	vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>",
	-- 		opts)

	-- 	vim.api.nvim_set_keymap("n", "<Leader>nh", ":lua require('neogen').generate({ type = 'file' })<CR>",
	-- 		opts)
	-- end

}
