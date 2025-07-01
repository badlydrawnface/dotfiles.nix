{ lib, fetchurl, pkgs, ... }: {      
      pname = "imjtool";
      version = "1.0.0";
      dontConfigure = true;
      dontBuild = true;
      dontStrip = true;
      src = fetchurl {
        url = "http://newandroidbook.com/tools/imjtool.tgz";
        sha256 = "sha256:027zlxsssfffhrlgfamcjn4whcarm8gh687xswz3mbmyra0rgspd";
      };
      setSourceRoot = "sourceRoot=`pwd`";
      nativeBuildInputs = [ autoPatchelfHook ];
      buildInputs = with pkgs; [
        zlib lzma bzip2
      ];
      propagatedBuildInputs = with pkgs; [
        lz4
      ];
      installPhase = ''
        mkdir -p $out/bin
        cp imjtool.ELF64 $out/bin/imjtool
      '';
}
