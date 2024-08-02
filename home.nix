{ pkgs, lib, inputs, ... }:

{  
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./waybar.nix
    ./hyprlock.nix
    #./anyrun.nix
  ];

  home = {
    username = "mars-monkey";
    homeDirectory = "/home/mars-monkey";
    stateVersion = "24.05";
    
    shellAliases = {
      apt = "nala";
      bt = "bluetoothctl power on && bluetoothctl remove 60:C5:E6:13:7A:63 && bluetoothctl scan on && sleep 2 && bluetoothctl pair 60:C5:E6:13:7A:63 && bluetoothctl connect 60:C5:E6:13:7A:63";
      cl = "clear";
      int = "ping -c 5 1.1.1.1";
      mt = "sudo mount /dev/nvme0n1p2 /mnt";
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

      l = "eza --icons --git";
      ez = "eza --all --icons --long --git --header";
    };
   
    sessionVariables = {
      EDITOR = "nvim";
    };
    
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
    };

    packages = with pkgs; [
      alacritty
      android-tools
      anyrun
      audacity
      bat
      bc
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
      lsd
      lua
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
      webcord
      wev
      wget
      whatip
      zoxide
    ];
  };

  fonts.fontconfig.enable = true;
  
  # Hyprland catppuccin style
  home.file.".config/hypr/mocha.conf".source =
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "hyprland";
      rev = "v1.3";
      hash = "sha256-jkk021LLjCLpWOaInzO4Klg6UOR4Sh5IcKdUxIn7Dis=";
    }
    + "/themes/mocha.conf";
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      source = [
        "~/.config/hypr/mocha.conf"
      ];
      monitor = ",highres,auto,1";
      "$terminal" = "kitty";
      xwayland.force_zero_scaling = true;
      

      input = {
        kb_layout = "us";
        follow_mouse = "1";
        touchpad.natural_scroll = "yes";
      };
      
      general = {
        gaps_in = "5";
        gaps_out = "10";
        border_size = "3";
        "col.active_border" = "$mauve";
        "col.inactive_border" = "$surface0";
        layout = "dwindle";
        allow_tearing = "true";
      };
      decoration = {
        rounding = "10";
        drop_shadow = "yes";
        shadow_range = "4";
        shadow_render_power = "3";
        "col.shadow" = "$surface1";

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


      gestures = {
        workspace_swipe = "true";
      };

      misc = {
        force_default_wallpaper = "0";
        vfr = "true";
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = "-0.5";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, $terminal"
        "$mod, C, killactive,"
        "$mod, M, exit,"
        "$mod, B, exec, librewolf"
        "$mod, O, exec, obsidian"
        "$mod, W, exec, webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
        "$mod, V, togglefloating,"
        "$mod, R, exec, $menu"
        "$mod, P, pseudo,"
        "$mod, O, togglesplit,"
        ", Print, exec, grimblast copysave area"
        
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

        "$mod, mouse_down, workspace, e-1"
        "$mod, mouse_up, workspace, e+1"

        # Reload hyprland
        "CTRL + ALT, delete, exec, hyprctl reload && systemctl restart --user waybar hypridle"
      ];
      binde = [
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_SINK@ 5%-"

        ",XF86MonBrightnessUp, exec, brillo -A 5"
        ",XF86MonBrightnessDown, exec, brillo -U 5"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      windowrulev2 = [
        "float, move onscreen 50% 50%, class:io.github.kaii_lb.Overskride" # Make overskride/iwgtk a popup window, move out later
        "float, move onscreen 50% 50%, class:org.twosheds.iwgtk"
        "float, move onscreen 50% 50%, class:iwgtk" # For the password prompt

        "bordercolor $red,xwayland:1" # Set the bordercolor to red if window is Xwayland
      ];
    };
  };

  programs = {
    home-manager.enable = true;
    bash.enable = true;    
    zoxide.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 100000;
    };

    nixvim = {
      enable = true;
      colorschemes.catppuccin.enable = true;

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
