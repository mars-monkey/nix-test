{ config, pkgs, lib, inputs, ... }:

{  
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "24.05";
    
    shellAliases = {
      apt = "nala";
      bt = "bluetoothctl power on && bluetoothctl connect 60:C5:E6:13:7A:63";
      cl = "clear";
      gp = "git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      hcf = "vim ~/nix/home.nix";
      hyp = "vim ~/.config/hypr/hyprland.conf";
      up = "nix flake update ~/nix";
      int = "ping -c 5 1.1.1.1";
      l = "ls -ah --color=auto";
      pi = "ssh dietpi@192.168.100.5";
      pib = "ssh dietpi@192.168.100.5 -t ./start.sh";
      rm = "trash";
      scf = "vim ~/nix/configuration.nix";
      srb = "sudo nixos-rebuild switch --flake ~/nix#mars-monkey-laptop && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      srbb = "sudo nixos-rebuild boot --flake ~/nix#mars-monkey-laptop && git -C ~/nix commit -a -m 'Local changes autocommit' && git -C ~/nix push";
      ts = "nix run nixpkgs#";
    };
   
    sessionVariables = {
      EDITOR = "vim";
      MOZ_ENABLE_WAYLAND = "1";
    };
    
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
    };

    packages = with pkgs; [
      andika
      android-tools
      audacity
      bitwarden
      brave
      brillo
      btop
      calibre
      chromium
      clapper
      cmatrix
      corefonts
      cowsay
      distrobox
      drawing
      du-dust
      eartag
      electron-mail
      eza
      fastfetch
      figlet
      fish
      font-awesome
      geogebra6
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
      librewolf
      libreoffice
      libva-utils
      lolcat
      lunar-client
      mangohud
      mprocs
      neofetch
      nix-index
      nixos-generators
      nushell
      ntfs3g
      obs-studio
      onlyoffice-bin
      pciutils
      plocate
      pfetch-rs
      ponysay
      prismlauncher
      rpi-imager
      sl
      snapshot
      speedtest-cli
      starship
      tealdeer
      xfce.thunar
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
      youtube-dl
      zellij
      zoxide
    ];
  };
  
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,1";
      "$terminal" = "kitty";
      

      input = {
        kb_layout = "us";
        follow_mouse = "1";
        touchpad.natural_scroll = "yes";
      };
      
      general = {
        gaps_in = "5";
        gaps_out = "10";
        border_size = "3";
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = "true";
      };

      decoration = {
        rounding = "10";
        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = "true";
          size = "3";
          passes = "2";
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_is_master = "true";
      };

      gestures = {
        workspace_swipe = "true";
      };

      misc = {
        force_default_wallpaper = "0";
        vfr = "true";
      };

      "device:epic-mouse-v1" = {
        sensitivity = "-0.5";
      };

      #windowrulev2 = "nomaximizerequest, class:.*";

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, B, exec, librewolf"
        "$mod, W, exec, webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo,"
        "$mod, O, togglesplit,"
        ", Print, exec, grimblast copy"
        
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2" 
        "$mod SHIFT, 3, movetoworkspace, 3" 
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        ",xf86audioraisevolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ",xf86audiolowervolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    bash.enable = true;    

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    kitty = {
      enable = true; 
      theme = "Catppuccin-Macchiato";

      settings = {
        enable_audio_bell = "no";
        copy_on_select = "clipboard";
        background_opacity = "0.8";
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
        editor = "vim";
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
