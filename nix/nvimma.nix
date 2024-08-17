{ pkgs, opts }:
let
  inherit (builtins)
    isBool mapAttrs readFile replaceStrings stringLength substring toJSON
    toString;
  nvimmaRtp = pkgs.stdenv.mkDerivation {
    name = "nvimma-rtp";
    src = ../nvim;
    buildPhase = ''
      mkdir -p $out/nvim
      mkdir -p $out/lua
      rm init.lua
    '';
    installPhase = ''
      cp -r lua $out/lua
      rm -r lua
      cp -r $out/lua $out/nvim
    '';
  };
  getAttrsRec = attrs:
    mapAttrs
    (k: v: if isBool v then if v then "true" else "false" else getAttrsRec v)
    attrs;
  luaOpts = let
    string = replaceStrings [ ''"'' ":" ] [ "" "=" ]
      (toString (toJSON (getAttrsRec opts)));
  in substring 1 ((stringLength string) - 2) string;
  vimInit = ''
    vim.g.nvimma = {
      ${luaOpts}
    }
  '';
in pkgs.neovim.override {
  configure = {
    packages.all.start = import ./plugins.nix { inherit pkgs; };
    customRC = ''
      lua <<EOF
      vim.loader.enable()
      vim.opt.rtp:prepend('${nvimmaRtp}/lua')
    '' + vimInit + (readFile ../nvim/init.lua) + ''
      vim.opt.rtp:prepend('${nvimmaRtp}/nvim')
      EOF
    '';
    extraMakeWrapperArgs = " "
      + ''--set LIBSQLITE_CLIB_PATH "${pkgs.sqlite.out}/lib/libsqlite3.so"''
      + " " + ''--set LIBSQLITE "${pkgs.sqlite.out}/lib/libsqlite3.so"'';
  };
}
