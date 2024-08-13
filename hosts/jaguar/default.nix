{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    loader = {
      efi.canTouchEfiVariables = true;

      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = false;
      };
    };

    tmp = {
      useTmpfs = false;
      tmpfsSize = "25%";
    };
  };

  fileSystems = {
    "/" = {
      device = "pool/root";
      fsType = "zfs";
    };
    
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
    
    "/nix" = {
      device = "pool/nix";
      fsType = "zfs";
    };
    
    "/home" = {
      device = "pool/home";
      fsType = "zfs";
    };
    
    "/safe" = {
      device = "pool/safe";
      neededForBoot = true;
      fsType = "zfs";
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    brillo.enable = true;

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
      ];
    };

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
  
  powerManagement = {
    enable = true;
    scsiLinkPolicy = "med_power_with_dipm";
  };

  nixpkgs = {
    hostPlatform.system = "x86_64-linux";

    config.allowUnfree = true;
  };

  system.stateVersion = "24.05";

  networking = {
    hostName = "jaguar";
    hostId = "8425e349";
    wireless.iwd.enable = true;
    nameservers = ["1.1.1.3" "1.0.0.3"];

    firewall = {
      enable = false;
      logRefusedConnections = true;
    };
 };

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  console = {
    useXkbConfig = true;
  };

  nix = {
    optimise = {
      automatic = true;
      dates = ["daily"];
    };

    settings = {
      trusted-users = ["@wheel"];

      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
    
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  programs = {
    virt-manager.enable = true;
    
    hyprland = {
      enable = true;
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 10d --keep 5";
    };
  };

  services = {
    blueman.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    locate.enable = true;
    printing.enable = true;
    thermald.enable = true;

    xserver.desktopManager.lxqt.enable = true;

    samba = {
      enable = true;
      securityType = "user";
      extraConfig = ''
        guest account = nobody
	mapt to guest = bad user
      '';
      shares = {
        public = {
	  path = "/DATA";
	  browseable = "yes";
	  "read only" = "no";
	  "guest ok" = "yes";
	};
      };
    };

    samba-wsdd = {
      enable = true;
    };

    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${pkgs.catppuccin-sddm-corners}/share/sddm/themes/catppuccin-sddm-corners";

      extraPackages = [
	pkgs.libsForQt5.qt5.qtgraphicaleffects
      ];
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      liberation_ttf
      (nerdfonts.override { fonts = ["Noto"]; })
    ];
    
    fontconfig = {
      enable = true;

      hinting = {
        enable = true;
        style = "full";
      };
    };
  };

  security.rtkit.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs; };

    users = {
      "mars-monkey" = import ./home.nix;
    };
  };

  users = {
    groups.netdev = {};
    mutableUsers = false;
    #defaultUserShell = pkgs.zsh;
    
    users.mars-monkey = {
      isNormalUser = true;
      extraGroups = [ "wheel" "netdev" "libvirtd" "video" ];
      hashedPassword = "$y$j9T$PPMehWHX4aaQ5oMN3igBV0$zXYtqyL4ez7knABEGRMIYTPk1YERI/aY/qOaxXXq1q5";
    };

    users.mars-monkey-de = {
      isNormalUser = true;
      extraGroups = [ "wheel" "netdev" "libvirtd" "video" ];
      hashedPassword = "$y$j9T$PPMehWHX4aaQ5oMN3igBV0$zXYtqyL4ez7knABEGRMIYTPk1YERI/aY/qOaxXXq1q5";
    };
  };

    # Use wayland pls uwu
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment = {
    /*persistence."/safe" = {
      hideMounts = true;
      directories = [
        "/var/log"
        #"/etc/NetworkManager/system-connections"
      ];
    };*/

    systemPackages = with pkgs; [
      gh
      git
      kitty
      librewolf
      vim
      webcord
      wget
      xwaylandvideobridge
      zoxide
    ];
  };
}

