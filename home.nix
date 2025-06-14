{
  lib,
  config,
  nixpkgs,
  pkgs,
  firefox-addons,
  nur,
  zen-browser,
  nix-vscode-extensions,
  system,
  ...
}:

with lib.hm.gvariant;

{

  nixpkgs.overlays = [
    nur.overlays.default
    nix-vscode-extensions.overlays.default
    # (final: prev: {
    #   zen-browser = zen-browser.packages."${system}".default;
    # })
    # (final: prev: {
    #   blender = prev.blender.override {
    #     cudaSupport = true;
    #     hipSupport = true;
    #     waylandSupport = true;
    #     # jackaudioSupport = true;
    #   };
    # })
    # (final: prev: {
    #   obs-studio = prev.obs-studio.override {
    #     cudaSupport = true;
    #     # hipSupport = true;
    #     # waylandSupport = true;
    #     # jackaudioSupport = true;
    #   };
    # })
  ];

  home.username = "hey";
  home.homeDirectory = "/home/hey";
  home.shellAliases."ll" = "eza -lha .";
  # programs.zsh.shellAliases."ll" = "eza -lha .";

  services.flameshot.enable = false;
  services.emacs.enable = true;
  # systemd.user.services.hello = {
  #   Unit = {
  #     Description = "amazing";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  #   Service = {
  #     ExecStart = "sleep 100";
  #   };
  # };

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.cudaSupport = true;

  home.stateVersion = "25.11"; # Please read the comment before changing.
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
      # pkgs.blender
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
      gimp3Plugins.gmic
      clang
      # emacsPackages.doom
      # nix-index
      # nix-index-database
      # zen-browser

      # It is sometimes useful to fine-tune packages, for example, by applying
      # overrides. You can do that directly here, just don't forget the
      # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # You can also create simple shell scripts directly inside your
      # configuration. For example, this adds a command 'my-hello' to your
      # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ]
    ++ [
      zen-browser.packages."${system}".default
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # home.file = {
  #   # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  #   # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  #   # # symlink to the Nix store copy.
  #   # ".screenrc".source = dotfiles/screenrc;

  #   # # You can also set the file content immediately.
  #   # ".gradle/gradle.properties".text = ''
  #   #   org.gradle.console=verbose
  #   #   org.gradle.daemon.idletimeout=3600000
  #   # '';
  # };

  home.file.".zsh-custom/themes/spaceship.zsh-theme".source =
    "${pkgs.spaceship-prompt}/share/zsh/themes/spaceship.zsh-theme";
  # home.file.".doom-git".source = builtins.fetchGit {
  #   url = "https://github.com/doomemacs/doomemacs.git";
  #   rev = "313e8fb48be6381aac7b42c6c742d6d363cc7d35";
  # };
  # home.file.".doom-git".recursive = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/hey/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    # EDITOR = "emacs";
  };

  home.sessionPath = [
    "$HOME/.doom-git/bin"
  ];

  programs.home-manager.enable = true;
  dconf.enable = true;
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
  ];
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding =
    "Print";
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command =
    "xdotool exec flameshot gui";
  # "/bin/sh -c \"XDG_CURRENT_DESKTOP=gnome XDG_SESSION_TYPE=wayland QT_QPA_PLATFORM=wayland ${pkgs.flameshot}/bin/flameshot gui\"";
  dconf.settings."org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name =
    "flameshot";
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  dconf.settings."org/gnome/desktop/session".idle-delay = mkUint32 0;
  dconf.settings."org/gnome/shell".disable-user-extensions = false;
  dconf.settings."org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
    tray-icons-reloaded.extensionUuid
    quick-settings-audio-panel.extensionUuid
  ];

  xdg.enable = true;

  xdg.mime.enable = true;
  #xdg.mime.defaultApplications."default-web-browser" = [ "zen-beta.desktop" ];
  xdg.mimeApps.enable = true;

  xdg.mimeApps.associations.added."text/plain" = [ "org.gnome.TextEditor.desktop" ];
  xdg.mimeApps.defaultApplications."text/plain" = [ "org.gnome.TextEditor.desktop" ];

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

  xdg.mimeApps.associations.added."x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
  xdg.mimeApps.associations.added."x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];

  programs.bash.enable = true;

  # programs.nixvim.enable = true;
  # programs.nixvim.defaultEditor = true;
  # programs.nixvim.colorschemes.tokyonight.enable = true;
  # programs.nixvim.colorschemes.tokyonight.settings.style = "storm";
  # programs.nixvim.globals.mapleader = " ";
  # programs.nixvim.globals.maplocalleader = " ";
  # programs.nixvim.globals.have_nerd_font = false;
  # programs.nixvim.clipboard.providers.wl-copy.enable = true;
  # # programs.nixvim.clipboard.providers.register = "unnamedplus";
  # programs.nixvim.opts.number = true;
  # programs.nixvim.opts.mouse = "a";
  # programs.nixvim.opts.showmode = false;
  # # programs.nixvim.opts.breakident = true;
  # programs.nixvim.opts.undofile = true;
  # programs.nixvim.opts.ignorecase = true;
  # programs.nixvim.opts.smartcase = true;
  # programs.nixvim.opts.signcolumn = "yes";
  # programs.nixvim.opts.updatetime = 250;
  # programs.nixvim.opts.timeoutlen = 300;
  # programs.nixvim.opts.splitright = true;
  # programs.nixvim.opts.splitbelow = true;
  # programs.nixvim.opts.list = true;
  # programs.nixvim.opts.listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";
  # programs.nixvim.opts.inccommand = "split";
  # programs.nixvim.opts.cursorline = true;
  # programs.nixvim.opts.scrolloff = 10;
  # programs.nixvim.opts.confirm = true;
  # programs.nixvim.opts.hlsearch = true;
  # programs.nixvim.autoGroups.kickstart-highlight-yank.clear = true;
  # programs.nixvim.plugins.telescope.enable = true;
  # programs.nixvim.plugins.telescope.extensions.fzf-native.enable = true;
  # programs.nixvim.plugins.telescope.extensions.ui-select.enable = true;
  # programs.nixvim.plugins.web-devicons.enable = true;
  # programs.nixvim.plugins.sleuth.enable = true;
  # programs.nixvim.plugins.comment.enable = true;
  # programs.nixvim.plugins.todo-comments.enable = true;
  # programs.nixvim.plugins.todo-comments.settings.signs = true;
  # programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
  #   # Useful for getting pretty icons, but requires a Nerd Font.
  #   nvim-web-devicons # TODO: Figure out how to configure using this with telescope
  # ];
  # programs.nixvim.autoCmd = [
  #   {
  #     event = ["TextYankPost"];
  #     desc = "Highlight when yanking (copying) text";
  #     group = "kickstart-highlight-yank";
  #     callback.__raw = ''
  #       function()
  #         vim.highlight.on_yank()
  #       end
  #     '';
  #   }
  # ];
  # programs.nixvim.extraConfigLuaPre = ''
  #   if vim.g.have_nerd_font then
  #       require('nvim-web-devicons').setup {}
  #   end
  # '';
  # programs.nixvim.extraConfigLuaPost = ''
  #   -- vim: ts=2 sts=2 sw=2 et
  # '';
  # programs.nixvim.keymaps = [
  #   # Clear highlights on search when pressing <Esc> in normal mode
  #   {
  #       mode = "n";
  #       key = "<Esc>";
  #       action = "<cmd>nohlsearch<CR>";
  #   }
  #   # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  #   # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  #   # is not what someone will guess without a bit more experience.
  #   #
  #   # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  #   # or just use <C-\><C-n> to exit terminal mode
  #   {
  #       mode = "t";
  #       key = "<Esc><Esc>";
  #       action = "<C-\\><C-n>";
  #       options = {
  #           desc = "Exit terminal mode";
  #       };
  #   }
  #   # TIP: Disable arrow keys in normal mode
  #   /*
  #   {
  #       mode = "n";
  #       key = "<left>";
  #       action = "<cmd>echo 'Use h to move!!'<CR>";
  #   }
  #   {
  #       mode = "n";
  #       key = "<right>";
  #       action = "<cmd>echo 'Use l to move!!'<CR>";
  #   }
  #   {
  #       mode = "n";
  #       key = "<up>";
  #       action = "<cmd>echo 'Use k to move!!'<CR>";
  #   }
  #   {
  #       mode = "n";
  #       key = "<down>";
  #       action = "<cmd>echo 'Use j to move!!'<CR>";
  #   }
  #   */
  #   # Keybinds to make split navigation easier.
  #   #  Use CTRL+<hjkl> to switch between windows
  #   #
  #   #  See `:help wincmd` for a list of all window commands
  #   {
  #       mode = "n";
  #       key = "<C-h>";
  #       action = "<C-w><C-h>";
  #       options = {
  #           desc = "Move focus to the left window";
  #       };
  #   }
  #   {
  #       mode = "n";
  #       key = "<C-l>";
  #       action = "<C-w><C-l>";
  #       options = {
  #           desc = "Move focus to the right window";
  #       };
  #   }
  #   {
  #       mode = "n";
  #       key = "<C-j>";
  #       action = "<C-w><C-j>";
  #       options = {
  #           desc = "Move focus to the lower window";
  #       };
  #   }
  #   {
  #       mode = "n";
  #       key = "<C-k>";
  #       action = "<C-w><C-k>";
  #       options = {
  #           desc = "Move focus to the upper window";
  #       };
  #   }
  # ];

  programs.alacritty.enable = true;
  # programs.alacritty.settings =

  programs.fastfetch.enable = true;
  # programs.fastfetch.settings.logo.source = "nixos_small";
  # programs.fastfetch.settings.logo.padding.right = 1;
  # programs.fastfetch.settings.display.size.binaryPrefix = 1;
  # programs.fastfetch.settings.display.color = "blue";
  # programs.fastfetch.settings.display.separator = " : ";
  programs.fastfetch.settings.modules = [
    # {
    #   type = "datetime";
    #   key = "Date";
    #   format = "{1}-{3}-{11}";
    # }
    # {
    #   type = "datetime";
    #   key = "Time";
    #   format = "{14}:{17}:{20}";
    # }
    # "break"
    # "player"
    # "media"

    "title"
    "separator"
    "os"
    # "host"
    # "bios"
    # "board"
    "chassis"
    "kernel"
    "uptime"
    "processes"
    "packages"
    "shell"
    # "display"
    # "brightness"
    # "monitor"
    "lm"
    "de"
    "wm"
    "wmtheme"
    "theme"
    "icons"
    "font"
    "cursor"
    # "wallpaper"
    "terminal"
    "terminalfont"
    "terminalsize"
    "terminaltheme"
    "cpu"
    "cpuusage"
    # "gpu"
    "memory"
    "swap"
    # "disk"
    "battery"
    "poweradapter"
    # "player"
    # "media"
    # "publicip"
    # "localip"
    # "wifi"
    "datetime"
    "locale"
    # "vulkan"
    # "opengl"
    # "opencl"
    # "users"
    # "bluetooth"
    "sound"
    # "gamepad"
    # "weather"
    # "netio"
    # "diskio"
    # "physicaldisk"
    "version"
    "break"
    "colors"
  ];

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

  fonts.fontconfig.enable = true;
  # programs.emacs.enable = true;
  # programs.doom-emacs.enable = true;
  # programs.doom-emacs.doomDir = { url = "$HOME/doom.d"; flake = true; };
  # programs.kitty.enable = true;
  # programs.kitty.shellIntegration.enableZshIntegration = true;
  # programs.kitty.shellIntegration.enableBashIntegration = true;

  programs.git.enable = true;
  programs.git.userName = "hey";
  programs.git.userEmail = "146812294+hey-adora@users.noreply.github.com";
  programs.git.extraConfig.safe.directory = "*";

  programs.mpv.enable = true;
  programs.mpv.config.hwdec = "auto";

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.plugins = [ "git" ];
  programs.zsh.oh-my-zsh.theme = "spaceship";
  programs.zsh.oh-my-zsh.custom = "$HOME/.zsh-custom";

  programs.atuin.enable = true;
  # programs.atuin.settings."db_path" = "/mnt/hdd1/atuin/history.db";
  # programs.atuin.settings."key_path" = "/mnt/hdd1/atuin/key";
  # programs.atuin.settings."session_path" = "/mnt/hdd1/atuin/session";
  programs.atuin.daemon.enable = true;
  programs.atuin.enableBashIntegration = true;
  programs.atuin.enableZshIntegration = true;

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;
  programs.vscode.profiles.default.userSettings."editor.formatOnSave" = true;
  programs.vscode.profiles.default.userSettings."rust-analyzer.check.command" = "clippy";
  programs.vscode.profiles.default.extensions = with pkgs.vscode-marketplace; [
    jnoortheen.nix-ide
    vscodevim.vim
    rust-lang.rust-analyzer
    tamasfe.even-better-toml
    fill-labs.dependi
    llvm-vs-code-extensions.vscode-clangd
    ms-dotnettools.csdevkit
    # vadimcn.vscode-lldb
  ] ++[
    pkgs.vscode-extensions.vadimcn.vscode-lldb
  ];

  programs.firefox.enable = true;
  #programs.firefox.package =
  programs.firefox.profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    gnome-shell-integration
  ];
  programs.firefox.profiles.default.settings = {
    "extensions.autoDisableScopes" = 0;
  };
}
