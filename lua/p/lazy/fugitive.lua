return {
	"tpope/vim-fugitive",


	config = function()
		-- Open Git fugitive Gf 
		vim.keymap.set("n", "<leader>Go", ":Git<CR>")
		-- stage current file Gsc
		vim.keymap.set("n", "<leader>Gsc", ":Gwrite<CR>")
		-- Git pull
		vim.keymap.set("n", "<leader>Gf", ":Git pull<CR>")
		-- run git command rGc 
		--vim.keymap.set(	
		-- git blame Gb
		vim.keymap.set("n", "<leader>Gb", ":Git blame<CR>")
		-- git diff Gdc 

	end
}
