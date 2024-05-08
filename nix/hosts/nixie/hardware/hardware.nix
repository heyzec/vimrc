{ pkgs, lib, systemSettings, ... }:

{
  hardware = {
    bluetooth.enable = true;
    bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
    uinput.enable = true;
    i2c.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
      ];
    };
  };

  nixpkgs.hostPlatform = systemSettings.system;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = true;
}