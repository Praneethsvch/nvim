return {
	"neovim/nvim-lspconfig",
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

		local unpack = unpack or table.unpack
		local function find_root_dir()
			local root_files = {
				"zephyr/CMakeLists.txt", -- Zephyr RTOS root indicator
				"CMakeLists.txt", -- Generic CMake project root indicator
				".git", -- Git repository root indicator
			}
			return require("lspconfig.util").root_pattern(unpack(root_files))
		end

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"asm_lsp",
				"arduino_language_server",
				"bashls",
				"clangd",
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

				["clangd"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.clangd.setup {
						capabilities = capabilities,
						root_dir = find_root_dir(),
					}
				end,

				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
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
