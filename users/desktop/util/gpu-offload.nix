{ lib, pkgs, ... }: let
    patchDesktop = pkg: appName: from: to: lib.hiPrio (
        pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
            addDir() {
                if [ -d ${pkg}/$1 ]; then
                    ${pkgs.coreutils}/bin/mkdir -p $out/$1
                    ${pkgs.coreutils}/bin/cp -r ${pkg}/$1/* $out/$1
                fi    
            }

            addDir bin
            addDir share/icons
            addDir share/pixmaps
            addDir share/mime

            ${pkgs.coreutils}/bin/mkdir -p $out/share/applications
            ${pkgs.gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
        ''
    );
    
    GPUOffloadApp = pkg: desktopName: patchDesktop pkg desktopName "^Exec=" "Exec=prime-run ";   
in GPUOffloadApp
