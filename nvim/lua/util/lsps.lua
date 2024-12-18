-- Setup module
local M = {}

-- Abbrev
M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.lspconfig = require("lspconfig")

-- Helper functions:
-- dynamic table of enabled languages
local dyn_server_table = function()
	local ret = {}
	for _, server in ipairs(M.langs.generic) do
		table.insert(ret, server)
	end
	for lang, servers in pairs(M.langs) do
		if lang ~= "generic" and vim.g.nvimma.langs[lang] and vim.g.nvimma.langs[lang].enabled then
			for _, server in ipairs(servers) do
				table.insert(ret, server)
			end
		end
	end
	return ret
end

-- Lsps
M.langs = {
	generic = { "codeqlls", "diagnosticls", "typos_lsp" },
	arduino = { "arduino_language_server" },
	assembly = { "asm_lsp" },
	awk = { "awk_ls" },
	bash = { "bashls" },
	cpp = { "ccls", "clangd" },
	css = { "cssls" },
	docker = { "docker_compose_language_service", "dockerls" },
	fennel = { "fennel_ls" },
	fortran = { "fortls" },
	gleam = { "gleam" },
	go = { "golangci_lint_ls", "gopls", "templ" },
	haskell = { "hls" },
	html = { "html", "htmx" },
	java = { "java_language_server", "jdtls" },
	javascript = { "biome", "postgres_lsp", "graphql", "tsserver" },
	json = { "jsonls" },
	kotlin = { "kotlin_language_server" },
	latex = { "texlab", "ltex" },
	lua = { "lua_ls" },
	markdown = { "marksman" },
	matlab = { "matlab_ls" },
	mcfunction = { "spyglassmc_language_server" },
	nginx = { "nginx_language_server" },
	nix = { "nil_ls", "nixd" },
	nushell = { "nushell" },
	ocaml = { "ocamllsp" },
	perl = { "perlnavigator" },
	php = { "phpactor" },
	protobuf = { "bufls", "protols" },
	python = { "basedpyright", "pylyzer" },
	rust = { "bacon_ls", "rust_analyzer" },
	scala = { "metals" },
	svelte = { "svelte" },
	tex = { "texlab", "ltex" },
	toml = { "taplo" },
	typescript = { "biome", "postgres_lsp", "graphql", "tsserver" },
	yaml = { "spectral", "yamlls" },
	zig = { "zls" },
}

-- Provide handlers for specific setups
M.setup_handlers = function(handlers)
	for _, server in ipairs(dyn_server_table()) do
		if handlers[server] then
			handlers[server]()
		else
			M.lspconfig[server].setup({
				capabilities = M.capabilities,
			})
		end
	end
end

-- Return module
return M
