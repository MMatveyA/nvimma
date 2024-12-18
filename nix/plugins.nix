{ pkgs }:
with pkgs.vimPlugins;
[
  alpha-nvim
  boole-nvim
  bufferline-nvim
  cmp-buffer
  cmp-nvim-lsp
  cmp-nvim-lua
  cmp-path
  cmp_luasnip
  codeium-nvim
  colorful-winsep-nvim
  comment-nvim
  conform-nvim
  dressing-nvim
  flash-nvim
  friendly-snippets
  gen-nvim
  gitsigns-nvim
  indent-blankline-nvim
  lsp-zero-nvim
  lspkind-nvim
  ltex_extra-nvim
  lualine-nvim
  luasnip
  luasnip-latex-snippets-nvim
  markdown-preview-nvim
  mini-surround
  neotest
  neotest-rust
  nvim-autopairs
  nvim-cmp
  nvim-colorizer-lua
  nvim-dap-virtual-text
  nvim-dap-ui
  nvim-dap
  nvim-dap-repl-highlights
  nvim-lint
  nvim-lspconfig
  nvim-notify
  nvim-treesitter-textobjects
  nvim-treesitter.withAllGrammars
  nvim-web-devicons
  oil-nvim
  plenary-nvim
  rainbow-csv-nvim
  telescope-nvim
  todo-comments-nvim
  tokyonight-nvim
  trim-nvim
  undotree-nvim
  vim-latex-live-preview
  vim-markdown-toc
  vim-mcfunction
  vim-tmux-navigator
  which-key-nvim
  wrapping-nvim
  telescope-dap-nvim
] ++ [ cmp-vimtex vimtex ]
