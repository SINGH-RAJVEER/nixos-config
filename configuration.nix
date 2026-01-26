{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        inputs.noctalia.nixosModules.default
    ];

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
    };


    boot = {
        plymouth = {
            enable = true;
            theme = "cubes";
            themePackages = with pkgs; [
                (adi1090x-plymouth-themes.override {
                    selected_themes = [
                        "cubes"
                    ];
                })
            ];
        };

        consoleLogLevel = 0;

        initrd = {
            verbose = false;
            availableKernelModules = [ "amdgpu" ];
        };

        loader = {
            timeout = 0;
            systemd-boot.enable = true;
            efi = {
                canTouchEfiVariables = true;
                efiSysMountPoint = "/boot";
            };
        };

        kernelParams = [
            "quiet"
            "splash"
            "loglevel=0"
            "boot.shell_on_fail"
            "udev.log_priority=0"
            "rd.systemd.show_status=false"
            "amdgpu.sg_display=0"
            "clearcpuid=rdseed"
        ];

        kernelModules = [
            "kvm-amd"
        ];

        kernelPackages = pkgs.linuxPackages_latest;
    };

    powerManagement.enable = true;

    virtualisation = {
        libvirtd.enable = true;

        docker = {
            enable = true;
            enableOnBoot = false;
        };
    };

    hardware = {
        enableAllFirmware = true;

        graphics = {
            enable = true;
            enable32Bit = true;
            extraPackages = [ pkgs.rocmPackages.clr.icd ];
        };

        nvidia = {
            modesetting.enable = true;
            open = true;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;

            prime = {
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };

                amdgpuBusId = "PCI:65:0:0";
                nvidiaBusId = "PCI:64:0:0";
            };

            powerManagement = {
                enable = true;
                finegrained = true;
            };
        };

        bluetooth = {
            enable = true;
            powerOnBoot = false;
            settings = {
                General = {
                    Experimental = true;
                    FastConnectable = true;
                };
            };
        };
    };

    services = {
        howdy = {
            enable = true;
            settings = {
                video.device_path = "/dev/video2";
                core.no_confirmation = true;
                video.capture_successful = false;
                video.dark_threshold = 95;
            };
        };

        linux-enable-ir-emitter.enable = true;

        gvfs.enable = true;
        udisks2.enable = true;

        displayManager = {
            gdm.enable = true;
            defaultSession = "niri";
            autoLogin.user = "rajveer";
            autoLogin.enable = false;
        };

        xserver = {
            enable = true;
            videoDrivers = [ 
                "amdgpu" 
                "nvidia" 
            ];
            xkb.layout = "us";
        };

        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        asusd.enable = true;

        upower = {
            enable = true;
            percentageAction = 1;
            criticalPowerAction = "PowerOff";
            allowRiskyCriticalPowerAction = true;
        };

        logind.settings.Login = {
            HandleLidSwitch = "suspend";
            HandleLidSwitchExternalPower = "ignore";
        };

        keyd = {
            enable = true;
            keyboards = {
                "default" = {
                    ids = [ "*" ];
                    settings = {
                        main = {
                            capslock = "esc";
                            esc = "capslock";
                            leftcontrol = "leftalt";
                            leftalt = "leftcontrol";
                            rightcontrol = "rightalt";
                            rightalt = "rightcontrol";
                        };
                    };
                };
            };
        };

        noctalia-shell = {
            enable = true;
            package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };

        flatpak.enable = true;

        redis.servers."local".enable = true;
    };

    programs = {
        niri.enable = true;

        appimage = {
            enable = true;
            binfmt = true;
        };

        nix-ld.enable = true;

        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            ohMyZsh = {
                enable = true;
                plugins = [
                    "git"
                    "history-substring-search"
                    "sudo"
                    "web-search"
                    "colored-man-pages"
                ];
            };
        };
    };

    networking = {
        hostName = "nixos";
        firewall.enable = true;
        networkmanager.enable = true;
    };

    time.timeZone = "Asia/Kolkata";

    users.users.rajveer = {
        isNormalUser = true;
        description = "Rajveer Singh";
        shell = pkgs.zsh;
        extraGroups = [ 
            "wheel" 
            "libvirtd" 
            "networkmanager" 
            "docker"
            "kvm"
        ];
    };

    nixpkgs.config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        users.rajveer = import ./home.nix;
    };

    security = {
        sudo-rs = {
            enable = true;
            wheelNeedsPassword = true;
        };
        polkit.enable = true;
        rtkit.enable = true;

        pam.services = let
            howdyPam = {
                control = lib.mkForce "sufficient";
                modulePath = "${config.services.howdy.package}/lib/security/pam_howdy.so";
                order = 110;
            };
        in {
            sudo.rules.auth.howdy = howdyPam;
            login.rules.auth.howdy = howdyPam;
            "polkit-1".rules.auth.howdy = howdyPam;
            noctalia-shell.rules.auth.howdy = howdyPam;
            quickshell.rules.auth.howdy = howdyPam;
        };
    };

    environment = { 
        sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
            NIXOS_OZONE_WL = "1";
        };

        systemPackages = with pkgs; [
            asusctl
            inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
            (pkgs.callPackage ./configs/helium.nix { })
        ];
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ 
            pkgs.xdg-desktop-portal-gtk 
            pkgs.kdePackages.xdg-desktop-portal-kde
            pkgs.xdg-desktop-portal-wlr
        ];
    };


    fonts.packages = with pkgs; [
        nerd-fonts._3270
    ];

    nix = {
        extraOptions = ''
            access-tokens = github.com=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
        '';

        # remove images older than a week
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    system.stateVersion = "25.11";
}
