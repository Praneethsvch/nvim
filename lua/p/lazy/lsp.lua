return {
	"neovim/nvim-lspconfig",
	"rhysd/vim-clang-format",
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
		require('lspconfig')
		local cmp = require('cmp')
		local cmp_lsp = require('cmp_nvim_lsp')
		local capabilities = vim.tbl_deep_extend(
		"force",
		{},
		vim.lsp.protocol.make_client_capabilities(),
		cmp_lsp.default_capabilities())

		-- Setup for ccls
		local lspconfig = require('lspconfig')

		lspconfig.ccls.setup{
			init_options = {
				compilationDatabaseDirectory = "build",
				index = {
					threads = 0,
				},
				clang = {
					excludeArgs = { "-frounding-math"} -- Exclude the problematic argument
				},
			},
			-- other configuration options
		}


		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"asm_lsp",
				"arduino_language_server",
				"bashls",
				"lua_ls",
				"rust_analyzer",
				"tsserver",
				"marksman",
				"ltex",
				"pyre",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup {
						capabilities = capabilities
					}
				end,

				["lua_ls"] = function()
					lspconfig.lua_ls.setup {
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								}
							}
						}
					}
				end,
			}
		})

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd('LspAttach', {
			group = vim.api.nvim_create_augroup('UserLspConfig', {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
				vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
				vim.keymap.set('n', '<space>f', function()
					vim.lsp.buf.format { async = true }
				end, opts)
			end,
		})


		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-u>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-d>'] = cmp.mapping.select_next_item(cmp_select),
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' }, -- For luasnip users.
			}, {
				{ name = 'buffer' },
			})
		})

		function ToggleDiagnostics()
			local diagnostics_visible = vim.diagnostic.config().underline
			vim.diagnostic.config({
				underline = not diagnostics_visible,
				virtual_text = not diagnostics_visible,
				signs = not diagnostics_visible,
				update_in_insert = not diagnostics_visible,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end

		vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua ToggleDiagnostics()<CR>',
		{ noremap = true, silent = true })
	end
}

