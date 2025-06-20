{
  lib,
  fetchurl,
  appimageTools,
};

#FIXME

let
  pname = "mudita-center";
  version = "3.0.1";
  src = fetchurl {
    url = "https://github.com/mudita/mudita-center/releases/download/${version}/Mudita-Center.AppImage";
    name = "Mudita-Center.AppImage";
    sha256 = "";
  };
  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # profile = ''
  #   export DISABLE_SUDO_PROMPT=1
  # '';

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/'Mudita Center.desktop' -t $out/share/applications
    substituteInPlace $out/share/applications/'Mudita Center.desktop' \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share

    mkdir -p $out/etc/udev/rules.d
    echo 'KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"' > $out/etc/udev/rules.d/91-mudita.rules
  ''

  meta = with lib; {
    description = "Desktop app to manage and update the Mudita Pure and Kompakt";
    homepage = "https://mudita.com/products/software-apps/mudita-center/";
    license = licenses.gpl3;
    maintainers = with maintainers; [ badlydrawnface ];
    platforms = [ "x86_64-linux" ];
    mainProgram = "mudita-center";
  };
};
