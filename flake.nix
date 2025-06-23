{
  description = "Home Manager configuration of hey";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      zen-browser,
      firefox-addons,
      nur,
      nix-vscode-extensions,
      nix-doom-emacs-unstraightened,
      nixvim,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      homeConfigurations."hey" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
            firefox-addons
            nur
            nixpkgs
            zen-browser
            system
            nix-vscode-extensions
            inputs
            ;
        };

        modules = [
          nixvim.homeModules.nixvim
          nix-doom-emacs-unstraightened.homeModule
          (

            {
              lib,
              config,
              nixpkgs,
              pkgs,
              firefox-addons,
              nur,
              # zen-browser,
              nix-vscode-extensions,
              system,
              inputs,
              ...
            }:

            with lib.hm.gvariant;

            {

              nixpkgs.overlays = [
                nur.overlays.default
                nix-vscode-extensions.overlays.default
              ];

              home.username = "hey";
              home.homeDirectory = "/home/hey";
              home.shellAliases."ll" = "eza -lha .";

              nixpkgs.config.allowUnfree = true;

              home.stateVersion = "25.11";
              home.packages =
                with pkgs;
                [
                  figma-linux
                  macchina
                  lshw
                  git
                  git-lfs
                  firefox
                  discord
                  neovim
                  wl-clipboard
                  vscodium
                  bitwarden-desktop
                  nixfmt-rfc-style
                  atuin
                  anydesk
                  github-desktop
                  dconf-editor
                  dconf2nix
                  vulkan-tools
                  pciutils
                  gnome-boxes
                  steam
                  ffmpeg-full
                  yt-dlp
                  gnomeExtensions.tray-icons-reloaded
                  gnomeExtensions.quick-settings-audio-panel
                  yazi
                  mpv
                  bolt-launcher
                  ncdu
                  krita
                  flameshot
                  sshfs
                  ripgrep
                  bat
                  xdotool
                  nvtopPackages.full
                  fastfetch
                  cachix
                  libva-utils
                  jetbrains.clion
                  qbittorrent
                  tor-browser
                  spaceship-prompt
                  telegram-desktop
                  aseprite
                  brave
                  whatsapp-for-linux
                  emacs
                  nixd
                  nil
                  cloc
                  zellij
                  python3
                  lsof
                  linuxPackages_latest.perf
                  nix-search-cli
                  procs
                  netscanner
                  bottom
                  btop
                  pik
                  eza
                  bat
                  dysk
                  rustscan
                  fd
                  television
                  noto-fonts
                  noto-fonts-cjk-sans
                  noto-fonts-emoji
                  liberation_ttf
                  hck
                  ripgrep
                  colordiff
                  gimp3
                  linux-manual
                  man-pages
                  man-pages-posix
		  powertop
		  powerstat
		  clinfo
		  # rcon-cli
                ]
                ++ [
                  inputs.zen-browser.packages."${system}".default
                ];

              home.sessionVariables = {
                QT_QPA_PLATFORM = "wayland";
                EDITOR = "nvim";
              };

              xdg.enable = true;
              xdg.mime.enable = true;
              xdg.mimeApps.enable = true;

              fonts.fontconfig.enable = true;

              programs.home-manager.enable = true;
              programs.bash.enable = true;
              programs.alacritty.enable = true;

              # man
              programs.man.enable = true;
              programs.man.generateCaches = false;

              # zsh
              programs.zsh.enable = true;
              programs.zsh.enableCompletion = true;
              programs.zsh.autosuggestion.enable = true;
              programs.zsh.syntaxHighlighting.enable = true;
              programs.zsh.oh-my-zsh.enable = true;
              programs.zsh.oh-my-zsh.plugins = [ "git" ];
              programs.zsh.oh-my-zsh.theme = "spaceship";
              programs.zsh.oh-my-zsh.custom = "$HOME/.zsh-custom";
              home.file.".zsh-custom/themes/spaceship.zsh-theme".source =
                "${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme";

              # zen browser
              xdg.mimeApps.associations.added."x-scheme-handler/http" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/https" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."text/html" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-htm" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-html" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-shtml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/xhtml+xml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-xhtml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-xht" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."default-web-browser" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/http" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/https" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."text/html" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-htm" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-html" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-shtml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/xhtml+xml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-xhtml" = [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-xht" = [ "zen-beta.desktop" ];

              # firefox
              programs.firefox.enable = true;
              programs.firefox.profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
                ublock-origin
                gnome-shell-integration
              ];
              programs.firefox.profiles.default.settings = {
                "extensions.autoDisableScopes" = 0;
              };

              # gnome
              xdg.mimeApps.associations.added."text/plain" = [ "org.gnome.TextEditor.desktop" ];
              xdg.mimeApps.defaultApplications."text/plain" = [ "org.gnome.TextEditor.desktop" ];

              dconf.enable = true;
              dconf.settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
                "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" # flameshot
              ];
              dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
              dconf.settings."org/gnome/desktop/session".idle-delay = mkUint32 0;
              dconf.settings."org/gnome/shell".disable-user-extensions = false;
              dconf.settings."org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
                tray-icons-reloaded.extensionUuid
                quick-settings-audio-panel.extensionUuid
              ];

              #flameshot
              services.flameshot.enable = false;
              dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding =
                "Print";
              dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command =
                "xdotool exec flameshot gui";
              dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name =
                "flameshot";

              # telegram
              xdg.mimeApps.associations.added."x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];

              # fastfetch
              programs.fastfetch.enable = true;
              programs.fastfetch.settings.modules = [
                "title"
                "separator"
                "os"
                "chassis"
                "kernel"
                "uptime"
                "processes"
                "packages"
                "shell"
                "lm"
                "de"
                "wm"
                "wmtheme"
                "theme"
                "icons"
                "font"
                "cursor"
                "terminal"
                "terminalfont"
                "terminalsize"
                "terminaltheme"
                "cpu"
                "cpuusage"
                "memory"
                "swap"
                "battery"
                "poweradapter"
                "datetime"
                "locale"
                "sound"
                "version"
                "break"
                "colors"
              ];

              # zed editor
              programs.zed-editor.enable = true;
              programs.zed-editor.extensions = [
                "nix"
                "toml"
                "elixir"
                "make"
              ];
              programs.zed-editor.userSettings.assistant.enable = false;
              programs.zed-editor.userSettings.lsp.rust-analyzer.binary.path_lookup = true;
              programs.zed-editor.userSettings.lsp.nix.binary.path_lookup = true;
              programs.zed-editor.userSettings.vim_mode = true;
              programs.zed-editor.userSettings.format_on_save = "on";
              programs.zed-editor.userSettings.theme.mode = "system";
              programs.zed-editor.userSettings.theme.light = "One Light";
              programs.zed-editor.userSettings.theme.dark = "One Dark";

              # obs
              programs.obs-studio.enable = true;
              programs.obs-studio.package = (
                pkgs.obs-studio.override {
                  cudaSupport = true;
                }
              );
              programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                obs-backgroundremoval
                obs-pipewire-audio-capture
                obs-gstreamer
                obs-vaapi
                obs-vkcapture
              ];

              # git
              programs.git.enable = true;
              programs.git.userName = "hey";
              programs.git.userEmail = "146812294+hey-adora@users.noreply.github.com";
              programs.git.extraConfig.safe.directory = "*";

              # mpv
              programs.mpv.enable = true;
              programs.mpv.config.hwdec = "auto";

              # atuin
              programs.atuin.enable = true;
              programs.atuin.daemon.enable = true;
              programs.atuin.enableBashIntegration = true;
              programs.atuin.enableZshIntegration = true;

              # vscode
              programs.vscode.enable = true;
              programs.vscode.package = pkgs.vscodium;
              programs.vscode.profiles.default.userSettings."editor.formatOnSave" = true;
              programs.vscode.profiles.default.userSettings."rust-analyzer.check.command" = "clippy";
              programs.vscode.profiles.default.extensions =
                with pkgs.vscode-marketplace;
                [
                  jnoortheen.nix-ide
                  vscodevim.vim
                  rust-lang.rust-analyzer
                  tamasfe.even-better-toml
                  fill-labs.dependi
                  llvm-vs-code-extensions.vscode-clangd
                  ms-dotnettools.csdevkit
                  bradlc.vscode-tailwindcss
                  svelte.svelte-vscode
                  esbenp.prettier-vscode
                  dbaeumer.vscode-eslint
                  # DioxusLabs.dioxus
                ]
                ++ [
                  pkgs.vscode-extensions.vadimcn.vscode-lldb
                ];

            }

          )
        ];
      };
    };
}
