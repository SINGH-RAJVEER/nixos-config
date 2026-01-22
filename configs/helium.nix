{ pkgs, lib }:

let
  pname = "helium";
  version = "0.8.3.1";

  src = pkgs.fetchurl {
    url = "https://github.com/imputnet/helium-linux/releases/download/${version}/helium-${version}-x86_64.AppImage";
    hash = "sha256-GGltZ0/6rGQJixlGz3Na/vAwOlTeUR87WGyAPpLmtKM=";
  };
  
  appimageContents = pkgs.appimageTools.extractType2 {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs': with pkgs'; [ ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${appimageContents}/helium.desktop $out/share/applications/${pname}.desktop
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    
    mkdir -p $out/share/icons/hicolor/512x512/apps
    cp ${appimageContents}/helium.png $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';
}