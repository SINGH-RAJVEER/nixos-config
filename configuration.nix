{ config, pkgs, lib, inputs, ... }:

{
    disabledModules = ["security/pam.nix"];

    imports =
        [
            ./hardware-configuration.nix
            "${inputs.nixpkgs-howdy}/nixos/modules/security/pam.nix"
            "${inputs.nixpkgs-howdy}/nixos/modules/services/security/howdy"
            "${inputs.nixpkgs-howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"
        ];

    # flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot = {
        # plymouth
        plymouth = {
            enable = true;
            theme = "dna";
            themePackages = with pkgs; [
                (adi1090x-plymouth-themes.override {
                    selected_themes = [ "rings" "dna" ];
                })
            ];
        };

        # silent-boot
        consoleLogLevel = 0;
        initrd.verbose = false;
        initrd.availableKernelModules = [ "amdgpu" ];
        loader.timeout = 0;
        loader.systemd-boot.enable = true;

        loader.efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot";
        };

        # kernel-params
        kernelParams = [
            "quiet"
            "splash"
            "loglevel=0"
            "boot.shell_on_fail"
            "udev.log_priority=3"
            "rd.systemd.show_status=false"
            "amdgpu.sg_display=0"
            "clearcpuid=rdseed"
        ];

        # kernel-modules
        kernelModules = [
            "kvm-amd"
        ];

        # latest kernel
        kernelPackages = pkgs.linuxPackages_latest;
    };

    powerManagement.enable = true;

    # virtualisation
    virtualisation = {
        libvirtd.enable = true;

        # docker
        docker = {
            enable = true;
            enableOnBoot = false;
        };
    };

    # hardware
    hardware = {
        enableAllFirmware = true;

        graphics = {
            enable = true;
            enable32Bit = true;
        };

        # nvidia
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

        # Bluetooth
        bluetooth = {
            enable = true;
            settings = {
                General = {
                    Experimental = true;
                    FastConnectable = true;
                };
            };
        };
    };

    # services
    services = {
        # howdy
        howdy = {
            enable = true;
            package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.stdenv.hostPlatform.system}.howdy;
            settings = {
                video.device_path = "/dev/video2";
                core.no_confirmation = true;
                video.capture_successful = false;
                video.dark_threshold = 90;
            };
        };

        linux-enable-ir-emitter = {
            enable = true;
            package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linux-enable-ir-emitter;
        };

        gvfs.enable = true;
        udisks2.enable = true;
        printing.enable = true;

        # GDM
        displayManager = {
            gdm.enable = true;
            defaultSession = "niri";
            autoLogin.user = "rajveer";
            autoLogin.enable = false;
        };

        xserver = {
            enable = true;
            excludePackages = with pkgs; [ ];

            videoDrivers = [ "amdgpu" "nvidia" ];

            xkb = {
                layout = "us";
            };
        };

        # PipeWire
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
        };

        # asus
        asusd.enable = true;

        # Battery
        upower = {
            enable = true;
            percentageLow = 15;
            percentageCritical = 5;
            percentageAction = 1;
            criticalPowerAction = "PowerOff";
            allowRiskyCriticalPowerAction = true;
        };

        # keyd
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

        # tor
        tor.enable = true;

        # mongodb
        mongodb.enable = true;
        mongodb.package = pkgs.mongodb-ce;

        # postgresql
        postgresql.enable = true;
    };



    programs = {
        # niri
        niri = {
            enable = true;
        };

        # appimage
        appimage = {
            enable = true;
            binfmt = true;
        };

        nix-ld.enable = true;

        # steam
        steam.enable = true;

        # zsh
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            ohMyZsh = {
                enable = true;
            };
        };
    };

    # networking
    networking = {
        hostName = "nixos";

        # firewall
        firewall = {
            enable = true;
            allowedUDPPorts = [ 53 67 ];
            trustedInterfaces = [ "ap0" ];
        };

        # network-manager
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
        };
    };

    # Set your time zone.
    time.timeZone = "Asia/Kolkata";

    # shell
    users.defaultUserShell = pkgs.zsh;

    # Define a user account
    users.users.rajveer = {
        isNormalUser = true;
        description = "Rajveer Singh";
        extraGroups = [ 
            "networkmanager" 
            "wheel" 
            "libvirtd" 
            "docker"
            "archtorify"
        ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # home-manager
    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        users.rajveer = import ./home.nix;
    };

    # Security
    security = {
        # sudo-rs
        sudo-rs = {
            enable = true;
            wheelNeedsPassword = true;
        };

        # polkit
        polkit.enable = true;

        # rtkit
        rtkit.enable = true;
    };

    # environment
    environment = { 
        sessionVariables = {
            WLR_NO_HARDWARE_CURSORS = "1";
            NIXOS_OZONE_WL = "1";
        };

        # system packages
        systemPackages = with pkgs; [
            docker-buildx
            docker-compose
            hyprlock
            hypridle
            asusctl
            inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".default
            tor
        ];
    };

    fonts.packages = with pkgs; [
        nerd-fonts._3270
    ];

    # remove images older than a week
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    system.stateVersion = "25.05";
}
