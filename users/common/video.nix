{ pkgs, ... }: {
    hardware = {
        amdgpu = {
            initrd.enable = true;
        };

        graphics = {
            enable = true;
            enable32Bit = true;

            extraPackages = with pkgs; [
                libdecor
                vulkan-loader
                vulkan-tools

                libva
                libvdpau-va-gl
                ocl-icd
                
                intel-media-driver
                vpl-gpu-rt
                intel-ocl
            ];
        };
    };

    environment.systemPackages = with pkgs; [
        mesa-demos
    ];
}
