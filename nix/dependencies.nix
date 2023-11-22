{pkgs, ...}: rec {
  toolchain = pkgs.rust-bin.stable.latest.default.override {
    extensions = ["rust-src"];
    targets = [
      "wasm32-unknown-unknown"
      "x86_64-unknown-linux-musl"
    ];
  };

  nativeBuildInputs = with pkgs;
    [
      sccache
      trunk
      cargo-zigbuild
      nodePackages.pnpm
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isLinux [mold clang]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin []
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (
      with pkgs.darwin.apple_sdk.frameworks; [
        CoreText
        OpenGL
        CoreServices
        AppKit
      ]
    );

  buildInputs = with pkgs; [
  ];

  all = [toolchain] ++ nativeBuildInputs ++ buildInputs;
}
