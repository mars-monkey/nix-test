{ pkgs, lib, inputs, ... }:

{  
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "24.05";
    
    shellAliases = {
      apt = "nala";
      bt = "bluetoothctl power on && bluetoothctl remove 60:C5:E6:13:7A:63 && bluetoothctl scan on && sleep 2 && bluetoothctl pair 60:C5:E6:13:7A:63 && bluetoothctl connect 60:C5:E6:13:7A:63";
      cl = "clear";
      hyp = "nvim ~/.config/hypr/hyprland.conf";
      int = "ping -c 5 1.1.1.1";
      pi = "ssh dietpi@192.168.100.5";
      pib = "ssh dietpi@192.168.100.5 -t ./start.sh";
      ts = "nix run nixpkgs#";

      fl = "nvim ~/nix/flake.nix";
      hm = "nvim ~/nix/home.nix";
      sy = "nvim ~/nix/configuration.nix";
      up = "nix flake update ~/nix && ~/nix/git.sh";
      gp = "~/nix/git.sh";
      rb = "sudo nixos-rebuild switch --flake ~/nix#mars-monkey-laptop && ~/nix/git.sh";
      rbb = "sudo nixos-rebuild boot --flake ~/nix#mars-monkey-laptop && ~/nix/git.sh";

      cd = "echo 'Use zoxide!'";
      l = "eza --icons --git --group-directories-first --sort=modified";
      ll = "eza --all --icons --long --git --header";
      ls = "eza --all --icons --long --git --header";
      rm = "trash";
    };
   
    sessionVariables = {
      EDITOR = "nvim";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
    };

    packages = with pkgs; [
      android-tools
      audacity
      bat
      bc
      bitwarden
      brave
      brillo
      btop
      calibre
      chromium
      clapper
      cmatrix
      cowsay
      distrobox
      drawing
      du-dust
      eartag
      eza
      fastfetch
      fd
      figlet
      fish
      font-awesome
      fzf
      gh
      gimp
      git
      go
      gparted
      grimblast
      hugo
      hw-probe
      intel-gpu-tools
      inter
      iotas
      iperf3
      jitsi
      keepassxc
      kitty
      kodi-wayland
      lf
      libreoffice
      librewolf
      libva-utils
      lolcat
      lunar-client
      mangohud
      mprocs
      neofetch
      nixos-generators
      ntfs3g
      nushell
      obs-studio
      obsidian
      onlyoffice-bin
      pciutils
      pfetch-rs
      ponysay
      prismlauncher
      rpi-imager
      sl
      snapshot
      speedtest-cli
      starship
      tealdeer
      trash-cli
      tree
      usbutils
      ventoy-full
      vim
      vlc
      waybar
      webcord
      wev
      wget
      whatip
      zoxide
    ];
  };
  
  programs = {
    home-manager.enable = true;
    bash.enable = true;    
    zsh.enable = true;
    zoxide.enable = true;

    nixvim = {
      enable = true;

      opts = {
        relativenumber = true;
      };
    };

    kitty = {
      enable = true; 
      theme = "Catppuccin-Mocha";

      settings = {
        enable_audio_bell = "no";
        copy_on_select = "clipboard";
        background_opacity = "0.8";
        confirm_os_window_close = "-1";
      };

      font = {
        size = 12;
        name = "Noto Sans Mono";
      };
    };

    git = {
      enable = true;
      userName = "mars-monkey";
      userEmail = "91227993+mars-monkey@users.noreply.github.com";
    };

    gh = {
      settings = {
        editor = "nvim";
      };
      
      gitCredentialHelper = {
        enable = true;
        hosts = [ "github.com" ];
      };
    };
    
    mangohud = {
      enable = true;
      enableSessionWide = false;
    };
  };
  
  # requires reboot to set gtk stuff lol
  gtk = {
    enable = true;
    
    theme = {
      name = "Adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Noto Sans";
      size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = "0";
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = "0";
    };
  };
  
  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = lib.mkForce "adw-gtk3-dark";
    };
  };
}
