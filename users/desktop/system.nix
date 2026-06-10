{ lib, pkgs, ... }: {
    hardware.usb-modeswitch.enable = true;

    services = {
        # create consistent paths for GPUs
        udev.packages = let
            createRule = (name: id: pkgs.writeTextFile {
                name = "90-dri-${name}-gpu";
                text = lib.strings.join "\n" [
                    (lib.strings.join ", " [
                        "KERNEL==\"card*\""
                        "KERNELS==\"0000:${id}\""
                        "SUBSYSTEM==\"drm\""
                        "SUBSYSTEMS==\"pci\""
                        "SYMLINK+=\"dri/${name}-card\""
                    ])

                    (lib.strings.join ", " [
                        "KERNEL==\"renderD*\""
                        "KERNELS==\"0000:${id}\""
                        "SUBSYSTEM==\"drm\""
                        "SUBSYSTEMS==\"pci\""
                        "SYMLINK+=\"dri/${name}-render\""
                    ])
                ];

                destination = "/etc/udev/rules.d/90-dri-${name}-gpu.rules";
            });
        in [
            (createRule "intel" "07:00.0")
            (createRule "nvidia" "01:00.0")
        ];

        openssh = {
            enable = true;
            ports = [ 22 ];
            
            settings = {
                PasswordAuthentication = true;
                AllowedUsers = null;
                PermitRootLogin = "no";
            };
        };
    };

    networking = {
        interfaces.enp15s0 = {
            ipv4.addresses = [{
                address = "192.168.1.4";
                prefixLength = 24;
            }];
            
            useDHCP = false;
        };
    };

    environment.sessionVariables = {
        __EGL_VENDOR_LIBRARY_FILENAMES = "${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json";
        VK_ICD_FILENAMES               = "${pkgs.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json:${pkgs.mesa}/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
}
