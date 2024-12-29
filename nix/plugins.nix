{ pkgs }:
with pkgs.vimPlugins;
[
  alpha-nvim
  boole-nvim
  bufferline-nvim
  cmp-buffer
  cmp-nvim-lsp
  cmp-nvim-lua
  cmp-nvim-ultisnips
  cmp-path
  codeium-nvim
  colorful-winsep-nvim
  comment-nvim
  conform-nvim
  dressing-nvim
  flash-nvim
  gen-nvim
  gitsigns-nvim
  indent-blankline-nvim
  lsp-zero-nvim
  lspkind-nvim
  ltex_extra-nvim
  lualine-nvim
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
  telescope-dap-nvim
  todo-comments-nvim
  tokyonight-nvim
  trim-nvim
  undotree-nvim
  vim-latex-live-preview
  vim-markdown-toc
  vim-mcfunction
  vim-snippets
  vim-tmux-navigator
  which-key-nvim
  wrapping-nvim
  ultisnips
] ++ [ cmp-vimtex vimtex ]
