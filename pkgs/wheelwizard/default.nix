{
  lib,
  buildDotnetModule,
  dotnetCorePackages,
  fetchFromGitHub,
  makeDesktopItem,
  glew,
  libGL,
  libICE,
  libSM,
  libXcursor,
  libXext,
  libXi,
  libXrandr,

  ...
}:

buildDotnetModule rec {
  pname = "wheelwizard";
  version = "2.3.2";
  src = fetchFromGitHub {
    owner = "teamwheelwizard";
    repo = "wheelwizard";
    rev = version;
    sha256 = "sha256-ZSuRPpXHH9BMTKNxuUTj9AWxKoFtFOiyn6JGKW+bDL0=";
  };
  dotnet-sdk = dotnetCorePackages.sdk_8_0;
  dotnet-runtime = dotnetCorePackages.runtime_8_0;

  nugetDeps = ./deps.json;

  runtimeDeps = [
    # avalonia
    glew
    libGL
    libICE
    libSM
    libXcursor
    libXext
    libXi
    libXrandr
  ];

  projectFile = "WheelWizard.sln";
  testProjectFile = "WheelWizard.Test/WheelWizard.Test.csproj";

  executables = [ "WheelWizard" ];

  desktopItems = [
    (makeDesktopItem {
      desktopName = "Wheel Wizard";
      name = "WheelWizard";
      icon = "wheelwizard";
      exec = "WheelWizard";
      # categories = [ "Gaming" ];
    })
  ];

  preFixup = ''
    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps,mime/packages}

    install -D ${src}/Flatpak/io.github.TeamWheelWizard.WheelWizard.desktop $out/share/applications/wheelwizard.desktop
    install -D ${src}/Flatpak/io.github.TeamWheelWizard.WheelWizard.png $out/share/icons/hicolor/256x256/apps/io.github.TeamWheelWizard.WheelWizard.png
    # so `nix run` works
    ln -s $out/bin/WheelWizard $out/bin/wheelwizard
  '';

  meta = with lib; {
    homepage = "https://github.com/teamwheelwizard/wheelwizard";
    description = "Mario Kart Wii Mod Manager and Retro Rewind Updater";
    license = licenses.gpl3;
    maintainers = with maintainers; [ badlydrawnface ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
