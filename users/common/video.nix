{ lib, pkgs, ... }: {
    services.xserver.videoDrivers = [ "amd" "modesetting" ];
    hardware = {
        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                vulkan-loader
                vulkan-validation-layers
                vulkan-extension-layer
                
                libdecor

                intel-media-driver
                vpl-gpu-rt

                intel-compute-runtime
                khronos-ocl-icd-loader

                libva
                # enable this for vdpau - libvdpau-va-gl
            ];
        };
    };

    environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
        
        __EGL_VENDOR_LIBRARY_FILENAMES = lib.mkDefault (lib.strings.join ":" [
            "/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json"
        ]);

        VK_ICD_FILENAMES = lib.mkDefault (lib.strings.join ":" [
            "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json"
            "/run/opengl-driver-32/share/vulkan/icd.d/intel_icd.i686.json"
            # for amd people
            "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json"
            "/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json"
        ]);
    };

    boot.kernelParams = [ "i915.enable_guc=3" ];
    environment.systemPackages = with pkgs; [
        mesa-demos
        libva-utils
        vulkan-tools
    ];
}
