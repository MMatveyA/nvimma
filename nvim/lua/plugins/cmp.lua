require("cmp_nvim_ultisnips").setup({})

-- Utility
local cmp = require("cmp")
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local theme = require("colours.theme").default
local util = require("util.util")

-- Setup nvim cmp
cmp.setup({
	completion = {
		completeopt = "menu,menuone,preview,noselect",
	},
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, item)
			local kind = require("lspkind").cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				symbol_map = { Codeium = "󰊤" },
			})(entry, item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. (strings[1] or "") .. "  "
			kind.menu = "    (" .. (strings[2] or "") .. ")"
			return kind
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.scroll_docs(-4),
		["<C-n>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp_ultisnips_mappings.compose({ "expand" })(fallback)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<Tab>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.compose({ "jump_forwards" })(fallback)
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.compose({ "jump_backwards" })(fallback)
		end, { "i", "s" }),
		["<C-f>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.compose({ "select_next_item" })(fallback)
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping(function(fallback)
			cmp_ultisnips_mappings.compose({ "select_prev_item" })(fallback)
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "ultisnips" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "vimtex" },
		{ name = "codeium" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 4 },
	}),
})

-- Override colours
util.sethl({
	"CmpItemKindConstant",
	"CmpItemKindConstructor",
	"CmpItemKindReference",
}, { fg = "NONE", bg = theme.red })
util.sethl({
	"CmpItemKindEnumMember",
	"CmpItemKindField",
	"CmpItemKindProperty",
}, { fg = "NONE", bg = theme.gold })
util.sethl({
	"CmpItemKindEvent",
	"CmpItemKindMethod",
	"CmpItemKindValue",
}, { fg = "NONE", bg = theme.cyan })
util.sethl({
	"CmpItemKindColor",
	"CmpItemKindText",
}, { fg = "NONE", bg = theme.green })
util.sethl({
	"CmpItemKindFolder",
	"CmpItemKindSnippet",
	"CmpItemKindUnit",
}, { fg = "NONE", bg = theme.orange })
util.sethl({
	"CmpItemKindFile",
	"CmpItemKindVariable",
}, { fg = "NONE", bg = theme.blue })
util.sethl({
	"CmpItemKindKeyword",
	"CmpItemKindOperator",
	"CmpItemKindTypeParameter",
}, { fg = "NONE", bg = theme.pink })
util.sethl({
	"CmpItemKindClass",
	"CmpItemKindEnum",
	"CmpItemKindFunction",
	"CmpItemKindInterface",
	"CmpItemKindModule",
	"CmpItemKindStruct",
}, { fg = "NONE", bg = theme.magenta })
