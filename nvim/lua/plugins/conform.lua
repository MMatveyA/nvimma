-- Setup auto formatting
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters = {
		black = { prepend_args = { "--fast" } },
		gleam = { prepend_args = { "format" } },
		hydrogen = { command = "", stdin = false },
		latexindent = { command = "latexindent", args = { "-" }, stdin = true },
		tex_fmt = { command = "tex-fmt", args = { "--stdin", "--print", "--quiet" }, stdin = true },
		proto = { command = "buf", args = { "format", "$FILENAME" }, stdin = true },
		taplo = { prepend_args = { "format", "$FILENAME" }, stdin = false },
		zig = { command = "zig", args = { "fmt", "$FILENAME" }, stdin = false },
	},
	formatters_by_ft = {
		asm = { "asmfmt" },
		astro = { "prettierd" },
		bib = { "tex_fmt" },
		c = { "clang-format" },
		cmake = { "cmake_format" },
		cpp = { "clang-format" },
		css = { "prettierd" },
		fennel = { "fnlfmt" },
		fortran = { "fprettify" },
		gleam = { "gleam" },
		go = { "gofmt" },
		-- haskell = { "ormulu" },
		html = { "prettierd" },
		hydrogen = { "hydrogen" },
		java = { "google-java-format" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		latex = { "tex_fmt" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		nix = { "nixfmt" },
		ocaml = { "ocamlformat" },
		perl = { "perltidy" },
		proto = { "proto" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
		sh = { "beautysh", "shellharden" },
		svelte = { "prettierd" },
		tex = { "tex_fmt" },
		toml = { "taplo" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		vue = { "prettierd" },
		yaml = { "yamlfmt" },
		zig = { "zig" },
		zsh = { "beautysh", "shellharden" },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Create :Format command
vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
