-- Abbrev
local lint = require("lint")

-- Setup linters
lint.linters_by_ft = {
	bash = { "shellcheck" },
	docker = { "hadolint" },
	go = { "golangcilint" },
	haskell = { "hlint" },
	java = { "checkstyle" },
	json = { "jsonlint" },
	lua = { "luacheck" },
	markdown = { "write_good", "markdownlint-cli2" },
	proto = { "protolint" },
	python = { "pylint" },
	yaml = { "yamllint" },
	zsh = { "shellcheck" },
}

-- Setup automatic linting
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint()
	end,
})
