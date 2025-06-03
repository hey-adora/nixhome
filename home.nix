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
    (final: prev: {
      zen-browser = zen-browser.packages."${system}".default;
    })
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
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "hey";
  home.homeDirectory = "/home/hey";

  services.flameshot.enable = true;

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.cudaSupport = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
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
    # pkgs.cudaPackages.cudatoolkit
    # pkgs.obs-studio
    # pkgs.graphite
    tor-browser
    spaceship-prompt
    telegram-desktop
    zen-browser
    # pkgs.rustup
    # pkgs.gcc
    # pkgs.openssl
    # zen-browser.packages."${system}".default
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  # Let Home Manager install and manage itself.
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
  #dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  #dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  xdg.enable = true;

  xdg.mime.enable = true;
  #xdg.mime.defaultApplications."default-web-browser" = [ "zen-beta.desktop" ];
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
  #xdg.mimeApps.defaultApplications."default-web-browser" = [ "zen-beta.desktop" ]; #text/html

  # [Added Associations]
  # text/plain=org.gnome.TextEditor.desktop;
  # x-scheme-handler/http=zen-beta.desktop;
  # x-scheme-handler/https=zen-beta.desktop;
  # x-scheme-handler/chrome=zen-beta.desktop;
  # text/html=zen-beta.desktop;
  # application/x-extension-htm=zen-beta.desktop;
  # application/x-extension-html=zen-beta.desktop;
  # application/x-extension-shtml=zen-beta.desktop;
  # application/xhtml+xml=zen-beta.desktop;
  # application/x-extension-xhtml=zen-beta.desktop;
  # application/x-extension-xht=zen-beta.desktop;

  # [Default Applications]
  # default-web-browser=zen-beta.desktop
  # text/plain=org.gnome.TextEditor.desktop
  # x-scheme-handler/http=zen-beta.desktop
  # x-scheme-handler/https=zen-beta.desktop
  # x-scheme-handler/chrome=zen-beta.desktop
  # text/html=zen-beta.desktop
  # application/x-extension-htm=zen-beta.desktop
  # application/x-extension-html=zen-beta.desktop
  # application/x-extension-shtml=zen-beta.desktop
  # application/xhtml+xml=zen-beta.desktop
  # application/x-extension-xhtml=zen-beta.desktop
  # application/x-extension-xht=zen-beta.desktop

  programs.bash.enable = true;

  programs.obs-studio.enable = true;
  # programs.obs-studio.package = pkgs.obs-studio;
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
  programs.atuin.settings."db_path" = "/mnt/hdd1/atuin/history.db";
  programs.atuin.settings."key_path" = "/mnt/hdd1/atuin/key";
  programs.atuin.settings."session_path" = "/mnt/hdd1/atuin/session";
  programs.atuin.daemon.enable = true;
  programs.atuin.enableBashIntegration = true;
  programs.atuin.enableZshIntegration = true;

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;
  programs.vscode.profiles.default.userSettings."editor.formatOnSave" = true;
  programs.vscode.profiles.default.extensions = [
    pkgs.vscode-marketplace.jnoortheen.nix-ide
    pkgs.vscode-marketplace.vscodevim.vim
    pkgs.vscode-marketplace.rust-lang.rust-analyzer
    pkgs.vscode-marketplace.tamasfe.even-better-toml
    pkgs.vscode-marketplace.fill-labs.dependi
    pkgs.vscode-marketplace.llvm-vs-code-extensions.vscode-clangd
  ];

  programs.firefox.enable = true;
  #programs.firefox.package =
  #repos.rycee.firefox-addons
  programs.firefox.profiles.default.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    ublock-origin
    gnome-shell-integration
  ];
  #programs.firefox.profiles.default.extensions.packages = with firefox-addons.packages.${pkgs.system}; [ ublock-origin ];
  programs.firefox.profiles.default.settings = {
    "extensions.autoDisableScopes" = 0;
  };
  #programs.firefox.profiles.myprofile.extensions.packages
}
