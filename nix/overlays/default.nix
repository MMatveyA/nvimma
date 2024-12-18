{ pkgs }:
let mac-frameworks = pkgs.darwin.apple_sdk.frameworks;
in {
  asm-lsp = pkgs.rustPlatform.buildRustPackage {
    cargoHash = "sha256-MwUI9xJ+vBTc+x2gjWesld9y/PqVnJ1LJpZ6d4URJAE=";
    doCheck = false;
    name = "asm-lsp";
    version = "0.7.3";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    buildInputs = with pkgs;
      [ pkg-config openssl ] ++ (if pkgs.stdenv.isDarwin then
        with mac-frameworks; [ SystemConfiguration ]
      else
        [ ]);
    src = builtins.fetchGit {
      ref = "master";
      rev = "615cb1bbf7d42c98bf341a03c27d5241fab0e8f4";
      url = "https://github.com/bergercookie/asm-lsp";
    };
  };
  bacon-ls = pkgs.rustPlatform.buildRustPackage {
    cargoHash = "sha256-xst1CZrtEQQl7nZB57TPHHuiSVJCE96R1MvzJEmigho=";
    name = "bacon-ls";
    version = "0.3.0";
    src = builtins.fetchGit {
      ref = "main";
      rev = "e25fd5520e59882b3429db8648518e12be0042db";
      url = "https://github.com/crisidev/bacon-ls";
    };
  };
  cmakelang = pkgs.buildPythonPackage {
    name = "cmakelang";
    version = "0.6.13";
    src = builtins.fetchurl {
      url =
        "https://files.pythonhosted.org/packages/74/c0/75d4806cf21dcb4198e9fba02f4d2fa61c8db919b7db788862d9cd5f4433/cmakelang-0.6.13.tar.gz";
      hash = pkgs.lib.fakeHash;
    };
  };
  mesonls = pkgs.stdenv.mkDerivation {
    name = "mesonls";
    version = "4.3.1";
    src = builtins.fetchGit {
      ref = "main";
      rev = "c9875b6df1bc494ff9f733ad05fe5d9b67d155de";
      url = "https://github.com/JCWasmx86/mesonlsp";
    };
  };
  protols = pkgs.rustPlatform.buildRustPackage {
    cargoHash = "sha256-yKFvaxnU3ZtX1/AXkNhvw5CxPzesooGas6Cc1qFpMrQ=";
    name = "protols";
    version = "0.2.1";
    src = builtins.fetchGit {
      ref = "main";
      rev = "fec7bfb3de4a120ad608c639c50e572bf795751e";
      url = "https://github.com/coder3101/protols";
    };
  };
  vimPlugins = pkgs.vimPlugins // {
    bufferline-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "bufferline-nvim";
      src = builtins.fetchGit {
        ref = "main";
        rev = "0b2fd861eee7595015b6561dade52fb060be10c4";
        url = "https://github.com/akinsho/bufferline.nvim";
      };
    };
    codeium-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "codeium-nvim";
      src = builtins.fetchGit {
        ref = "main";
        rev = "d3b88eb3aa1de6da33d325c196b8a41da2bcc825";
        url = "https://github.com/Exafunction/codeium.nvim";
      };
    };
    colorful-winsep-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "colorful-winsep-nvim";
      src = builtins.fetchGit {
        ref = "alpha";
        rev = "72cf292b9b49c371b3d9333d2ff2146b0bceab04";
        url = "https://github.com/nvim-zh/colorful-winsep.nvim";
      };
    };
    cmp-vimtex = pkgs.vimUtils.buildVimPlugin {
      name = "cmp-vimtex";
      src = pkgs.fetchFromGitHub {
        owner = "micangl";
        repo = "cmp-vimtex";
        rev = "613fbfc54d9488252b0b0289d6d1d60242513558";
        hash = "sha256-07FqXsRe0RP5f3b6osrsi5gai+bZi9ybm5JL/nnBH+4=";
      };
    };
    gen-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "gen-nvim";
      src = builtins.fetchGit {
        ref = "main";
        rev = "bd19cf584b5b82123de977b44105e855e61e5f39";
        url = "https://github.com/David-Kunz/gen.nvim";
      };
    };
    luasnip-latex-snippets-nvim = pkgs.fetchFromGitHub {
      owner = "evesdropper";
      repo = "luasnip-latex-snippets.nvim";
      rev = "c6b5b5367dd4bb8419389f5acf528acf296adcdd";
      hash = "sha256-calv4nF1yxJyehQC+l0p4psI+f4Kg49K6XziCkH9I1Q=";
    };
    mini-surround = pkgs.vimUtils.buildVimPlugin {
      name = "mini-surround";
      src = builtins.fetchGit {
        ref = "main";
        rev = "27096c1a27324ee8f2044ea2adc77366d8a782de";
        url = "https://github.com/echasnovski/mini.surround";
      };
    };
    nvim-dap-repl-highlights = pkgs.vimUtils.buildVimPlugin {
      name = "nvim-dap-repl-highlights";
      src = builtins.fetchGit {
        ref = "master";
        rev = "a7512fc0a0de0c0be8d58983939856dda6f72451";
        url = "https://github.com/LiadOz/nvim-dap-repl-highlights";
      };
    };
    rainbow-csv-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "rainbow-csv-nvim";
      src = builtins.fetchGit {
        ref = "main";
        url = "https://github.com/cameron-wags/rainbow_csv.nvim";
        rev = "7f3fddfe813641035fac2cdf94c2ff69bb0bf0b9";
      };
    };
    undotree-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "undotree-nvim";
      src = builtins.fetchGit {
        ref = "main";
        rev = "eab459ab87dd249617b5f7187bb69e614a083047";
        url = "https://github.com/jiaoshijie/undotree";
      };
    };
    vim-mcfunction = pkgs.vimUtils.buildVimPlugin {
      name = "vim-mcfunction";
      src = builtins.fetchGit {
        ref = "master";
        rev = "074aa25dd3128bb9de174e7e7039c3c76bbe5fb4";
        url = "https://github.com/CrystalAlpha358/vim-mcfunction";
      };
    };
  };
}
