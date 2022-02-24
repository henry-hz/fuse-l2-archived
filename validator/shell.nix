{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "cpp_project";
  buildInputs = with pkgs; [
    libtool
    automake
    autoconf
    autogen
    rocksdb
    gmp
    boost
    cmake
    ninja
    swig
    pcre
    bison
    flex
    openssl
  ];

  nativeBuildInputs = [ pkgs.pkg-config ];

  shellHook = ''
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/fuse-arb/validator/arb-avm-cpp"
  '';
}
