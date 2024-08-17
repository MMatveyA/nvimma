-- Setup dressing nvim
require("dressing").setup({
	input = { enabled = true, default_prompt = "Input: ", trim_prompt = true },
	select = { enabled = true, backend = { "telescope", "builtin", "fzf" } },
})
