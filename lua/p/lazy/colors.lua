return {
	--"rose-pine/neovim",
	--name = "rose-pine",
	--config = function()
	--	vim.opt.termguicolors = true

	--	-- 1) Create autocmd FIRST (so it catches the colorscheme load)
	--	vim.api.nvim_create_autocmd("ColorScheme", {
	--		callback = function()
	--			-- Works in GUIs; in terminals it depends on terminal support
	--			vim.cmd("highlight Cursor guifg=#000000 guibg=#00FF00 gui=NONE")

	--			-- Optional: make insert-mode cursor stand out too
	--			vim.cmd("highlight iCursor guifg=#000000 guibg=#FF00FF gui=NONE")
	--			vim.opt.guicursor =
	--			"n-v-c:block-Cursor,i-ci-ve:block-iCursor,r-cr:hor20,o:hor50"
	--		end,
	--	})

	--	require("rose-pine").setup({
	--		variant = "auto",
	--		dark_variant = "main",
	--		styles = { bold = true, italic = false, transparency = true },
	--		highlight_groups = { NormalFloat = { bg = "none" } },
	--	})

	--	-- 2) Now apply colorscheme (this triggers ColorScheme autocmd)
	--	vim.cmd("colorscheme rose-pine")

	--	-- 3) Force-run once in case something else re-highlights later
	--	vim.cmd("doautocmd ColorScheme")
	--end,

	-- "yonatan-perel/lake-dweller.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("lake-dweller").setup({
	-- 		-- your options here
	-- 	})
	-- 	vim.cmd.colorscheme("lake-dweller")
	-- end,
	--

	--"EdenEast/nightfox.nvim",
	--config = function()
	--	vim.cmd.colorscheme("carbonfox")
	--end,
	--

	--"folke/tokyonight.nvim",
	--lazy = false,
	--priority = 1000,
	--opts = {},
	--config = function()
	--	vim.cmd.colorscheme("tokyonight-night")
	--end,

	"vague-theme/vague.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other plugins
	config = function()
		-- NOTE: you do not need to call setup if you don't want to.
		require("vague").setup({
			-- optional configuration here
		})
		vim.cmd("colorscheme vague")
	end


}
