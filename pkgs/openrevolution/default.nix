{ lib, fetchFromGitHub, pkgs, ... }:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "openrevolution";
  version = "2.8.1";

  src = fetchFromGitHub {
    owner = "ic-scm";
    repo = "openrevolution";
    tag = "v${finalAttrs.version}";
    hash = "sha256-honnTBVTG5a8SbYFF2GrqwkGbaLJW9yctSDoCILYO8c=";
  };

  nativeBuildInputs = with pkgs; [
    libgcc
    ffmpeg
    rtaudio
  ];

  buildInputs = with pkgs; [
    ffmpeg
    rtaudio
  ];

  buildPhase = ''
    g++ -O2 $src/src/rt_player/main.cpp -o brstm_rt -lrtaudio -lpthread -Wall
    g++ -O2 -std=c++0x $src/src/converter.cpp -o brstm_converter -Wall
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp brstm_rt $out/bin/brstm_rt
    cp brstm_converter $out/bin/brstm_converter
  '';

  meta = with lib; {
    description = "Decode, encode, play and convert BRSTM files and other Nintendo audio formats.";
    homepage = "https://github.com/ic-scm/openrevolution";
    license = licenses.gpl3;
    maintainers = with maintainers; [ badlydrawnface ];
    platforms = [ "i686-linux" "x86_64-linux" "aarch64-linux" ];
  };
})
