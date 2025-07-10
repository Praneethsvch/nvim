return {
	"L3MON4D3/LuaSnip",
	version = "2.*",
	build = "make install_jsregexp",
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		local i = ls.insert_node

		-- Define C Doxygen Snippets
		ls.add_snippets("c", {
			-- Generic Documentation
			s("dxg", {
				t({ "/**", " * @brief " }), i(1, "description"), t({ "", " *" }),
				t({ "", " */" })
			}),

			-- Function Documentation
			s("dxf", {
				t({ "/**", " * @brief " }), i(1, "Function description"), t({ "", " *" }),
				t({ "", " * @param " }), i(2, "param_name"), t({ " " }), i(3, "param description"),
				t({ "", " * @return " }), i(4, "return value description"),
				t({ "", " */" })
			}),

			-- Struct Documentation
			s("dxs", {
				t({ "/**", " * @struct " }), i(1, "StructName"),
				t({ "", " * @brief " }), i(2, "Struct description"),
				t({ "", " */" })
			}),

			-- Header File Documentation
			s("dxh", {
				t({ "/**", " * @file " }), i(1, "filename.h"),
				t({ "", " * @brief " }), i(2, "File description"),
				t({ "", " */" })
			})
		})

		---- Keybindings for jumping between snippet fields
		--vim.api.nvim_set_keymap("i", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>",
		--	{ noremap = true, silent = true })
		--vim.api.nvim_set_keymap("s", "<Tab>", "<cmd>lua require'luasnip'.jump(1)<CR>",
		--	{ noremap = true, silent = true })
		--vim.api.nvim_set_keymap("i", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>",
		--	{ noremap = true, silent = true })
		--vim.api.nvim_set_keymap("s", "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<CR>",
		--	{ noremap = true, silent = true })
	end

}
