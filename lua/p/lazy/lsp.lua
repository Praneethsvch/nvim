return {
	"neovim/nvim-lspconfig",
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local lsp_zero = require('lsp-zero')
	
		lsp_zero.preset("recommended")

		lsp_zero.on_attach(function(client, bufnr)
			-- see :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({buffer = bufnr})
		end)

		-- to learn how to use mason.nvim with lsp-zero
		-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
		require('mason').setup({})
		require('mason-lspconfig').setup({
			ensure_installed = {
				'clangd',
				'rust_analyzer'
			},
			handlers = {
				lsp_zero.default_setup,
			},
		})

	end
}
