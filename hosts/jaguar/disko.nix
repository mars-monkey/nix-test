# UEFI only GPT
let
  hostname = "jaguar";
  device = "by-id/nvme-LITEON_CL1-8D512_002007100VEX";
in {
  disko.devices = {
    disk."zdisk" = {
      device = "/dev/${device}";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          "windows-boot" = {
            label = "windows-boot";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
            };
          };
          "windows-root" = {
            label = "windows-root";
            size = "230G";
            content = {
              type = "filesystem";
              format = "ntfs";
            };
          };
          "${hostname}-zroot" = {
            label = "${hostname}-zroot";
            size = "100%";
            content = {
              type = "zfs";
              pool = "${hostname}-zroot";
            };
          };
          "${hostname}-zboot" = {
            label = "${hostname}-zboot";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
        };
      };
    };
    zpool."${hostname}-zroot" = {
      type = "zpool";
      options.ashift = "12";
      rootFsOptions = {
        # These are inherited to all child datasets as the default value
        mountpoint = "none";
        compression = "zstd";
        xattr = "sa";
        acltype = "posix";
      };

      datasets = {
        "ephemeral" = {
          type = "zfs_fs";
          options = {
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
        "ephemeral/nix" = {
          type = "zfs_fs";
          mountpoint = "/nix";
          options = {
            atime = "off";
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
        "safe" = {
          type = "zfs_fs";
          options = {
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
        "safe/persist" = {
          type = "zfs_fs";
          mountpoint = "/persist";
          options = {
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
        "safe/home" = {
          type = "zfs_fs";
          mountpoint = "/home";
          options = {
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
        "system-state" = {
          type = "zfs_fs";
          mountpoint = "/";
          options = {
            canmount = "noauto";
            mountpoint = "legacy";
          };
        };
      };
      postCreateHook = "zfs snapshot -r ${hostname}-zroot@blank";
    };
  };
}
