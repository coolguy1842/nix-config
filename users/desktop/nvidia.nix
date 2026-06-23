{ lib, config, pkgs, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];
    boot.blacklistedKernelModules = [ "nouveau" ];

    hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.latest;

        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;
        nvidiaSettings = true;

        prime = {
            offload = {
                enable = true;
                enableOffloadCmd = false;
            };
            
            intelBusId = "PCI:07:0:0";
            nvidiaBusId = "PCI:01:0:0";
        };
    };

    environment.systemPackages = with pkgs; [
        (writeShellScriptBin "check-gpu-usage"     (lib.readFile ./scripts/check-gpu-usage.sh))
        (writeShellScriptBin "prime-run-base"      (lib.readFile ./scripts/prime-run-base.sh))
        (writeShellScriptBin "prime-run"           (lib.readFile ./scripts/prime-run.sh))
        (writeShellScriptBin "prime-run-gamescope" (lib.readFile ./scripts/prime-run-gamescope.sh))
    ];

    environment.sessionVariables = {
        VK_LOADER_DRIVERS_DISABLE = "${pkgs.mesa}/share/vulkan/icd.d/nouveau_icd.x86_64.json,${config.boot.kernelPackages.nvidiaPackages.latest}/share/vulkan/icd.d/nvidia_icd.json";
    };
}
