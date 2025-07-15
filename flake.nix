{
  description = "Home Manager configuration of hey";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    # firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    # firefox-addons.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-doom-emacs-unstraightened.url = "github:marienz/nix-doom-emacs-unstraightened";
    # nix-doom-emacs-unstraightened.inputs.nixpkgs.follows = "nixpkgs";

    # nixvim.url = "github:nix-community/nixvim";
    # nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, zen-browser,
    # firefox-addons,
    nur, nix-vscode-extensions,
    # nix-doom-emacs-unstraightened,
    # nixvim,
    ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

      homeConfigurations."hey" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit
          # firefox-addons
            nur nixpkgs zen-browser system nix-vscode-extensions inputs;
        };

        modules = [
          # nixvim.homeModules.nixvim
          # nix-doom-emacs-unstraightened.homeModule
          (

            { lib, config, nixpkgs, pkgs,
            # firefox-addons,
            nur,
            # zen-browser,
            nix-vscode-extensions, system, inputs, ... }:

            with lib.hm.gvariant;

            {

              nixpkgs.overlays = [
                # inputs.nixvim.overlays.default
                nur.overlays.default
                nix-vscode-extensions.overlays.default
              ];

              home.username = "hey";
              home.homeDirectory = "/home/hey";
              home.shellAliases."ll" = "eza -lhag .";
              home.shell.enableShellIntegration = true;

              nixpkgs.config.allowUnfree = true;

              home.stateVersion = "25.11";
              home.packages = with pkgs;
                [
                  figma-linux
                  macchina
                  lshw
                  git
                  git-lfs
                  firefox
                  discord
                  # neovim
                  wl-clipboard
                  vscodium
                  bitwarden-desktop
                  # nixfmt-rfc-style
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
                  librewolf
                  clinfo
                  rcon-cli
                  cowsay
                  imagemagick
                  inkscape
                  nerd-fonts."m+"
                  nerd-fonts.noto
                  nerd-fonts.hack
                  nerd-fonts.tinos
                  nerd-fonts.lilex
                  nerd-fonts.arimo
                  nerd-fonts.agave
                  nerd-fonts._3270
                  nerd-fonts.ubuntu
                  nerd-fonts.monoid
                  nerd-fonts.lekton
                  nerd-fonts.hurmit
                  nerd-fonts.profont
                  nerd-fonts.monofur
                  nerd-fonts.iosevka
                  nerd-fonts.hasklug
                  nerd-fonts.go-mono
                  nerd-fonts.cousine
                  nerd-fonts.zed-mono
                  nerd-fonts.overpass
                  nerd-fonts.mononoki
                  nerd-fonts.meslo-lg
                  nerd-fonts.gohufont
                  nerd-fonts.d2coding
                  nerd-fonts._0xproto
                  nerd-fonts.monaspace
                  nerd-fonts.fira-mono
                  nerd-fonts.fira-code
                  nerd-fonts.blex-mono
                  nerd-fonts.anonymice
                  nerd-fonts.space-mono
                  nerd-fonts.liberation
                  nerd-fonts.im-writing
                  nerd-fonts.heavy-data
                  nerd-fonts.geist-mono
                  nerd-fonts.victor-mono
                  nerd-fonts.ubuntu-sans
                  nerd-fonts.ubuntu-mono
                  nerd-fonts.roboto-mono
                  nerd-fonts.intone-mono
                  nerd-fonts.inconsolata
                  nerd-fonts.envy-code-r
                  nerd-fonts.commit-mono
                  nerd-fonts.symbols-only
                  nerd-fonts.martian-mono
                  nerd-fonts.iosevka-term
                  nerd-fonts.adwaita-mono
                  nerd-fonts.terminess-ttf
                  nerd-fonts.open-dyslexic
                  nerd-fonts.atkynson-mono
                  nerd-fonts.sauce-code-pro
                  nerd-fonts.recursive-mono
                  nerd-fonts.jetbrains-mono
                  nerd-fonts.inconsolata-go
                  nerd-fonts.departure-mono
                  nerd-fonts.code-new-roman
                  nerd-fonts.caskaydia-mono
                  nerd-fonts.caskaydia-cove
                  nerd-fonts.shure-tech-mono
                  nerd-fonts.proggy-clean-tt
                  nerd-fonts.inconsolata-lgc
                  nerd-fonts.droid-sans-mono
                  nerd-fonts.daddy-time-mono
                  nerd-fonts.dejavu-sans-mono
                  nerd-fonts.bigblue-terminal
                  nerd-fonts.iosevka-term-slab
                  nerd-fonts.comic-shanns-mono
                  nerd-fonts.aurulent-sans-mono
                  nerd-fonts.fantasque-sans-mono
                  nerd-fonts.bitstream-vera-sans-mono
                  symbola
                  kbd
                  ubuntu_font_family
                  chromium
                  curlHTTP3
                  bash-completion
                  luanti
                  blesh
                  htop
                  tree-sitter
                  stylua
                  # nixfmt-tree
                  nixfmt-classic
                  lua-language-server
                  # vimPlugins.catppuccin-nvim
                ] ++ [ inputs.zen-browser.packages."${system}".default ];

              home.sessionVariables = {
                QT_QPA_PLATFORM = "wayland";
                EDITOR = "nvim";
              };

              xdg.enable = true;
              xdg.mime.enable = true;
              xdg.mimeApps.enable = true;

              fonts.fontconfig.enable = true;
              # fonts.fontconfig.defaultFonts.serif = [ "Liberation Serif" ];
              # fonts.fontconfig.defaultFonts.sansSerif = [ "Ubuntu" ];
              # fonts.fontconfig.defaultFonts.monospace = [ "Ubuntu Mono" ];
              fonts.fontconfig.defaultFonts.serif = [ "Noto Serif Regular" ];
              fonts.fontconfig.defaultFonts.sansSerif = [ "Noto Sans Regular" ];
              fonts.fontconfig.defaultFonts.monospace =
                [ "Noto Sans Mono Regular" ];
              fonts.fontconfig.defaultFonts.emoji = [ "Noto Color Emoji" ];

              programs.home-manager.enable = true;
              programs.alacritty.enable = true;

              # nvim
              programs.neovim.enable = true;
              xdg.configFile."nvim".enable = true;
              # xdg.configFile."nvim".source = "/home/hey/.config/home-manager/nvim";
              xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
                "/home/hey/.config/home-manager/nvim";
              programs.neovim.plugins = with pkgs.vimPlugins; [
                catppuccin-nvim
                telescope-nvim
                nvim-treesitter.withAllGrammars
                none-ls-nvim
                nvim-lspconfig
                nvim-cmp
                luasnip
                cmp_luasnip
                friendly-snippets
                cmp-nvim-lsp
                lsp-progress-nvim
                lualine-nvim
                trouble-nvim
              ];
              # programs.neovim.extraLuaConfig = ''
              #   vim.opt.number = true
              #   vim.opt.relativenumber = true
              #
              #   vim.opt.tabstop = 4
              #   vim.opt.softtabstop = 4
              #   vim.opt.shiftwidth = 4
              #   vim.opt.expandtab = true
              #
              #   vim.opt.smartindent = true
              #
              #   vim.opt.wrap = false
              #
              #   vim.opt.swapfile = false
              #   vim.opt.backup = false
              #   vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
              #   vim.opt.undofile = true
              #
              #   vim.opt.hlsearch = false
              #   vim.opt.incsearch = true
              #
              #   vim.opt.termguicolors = true
              #
              #   vim.opt.scrolloff = 8
              #   vim.opt.signcolumn = "yes"
              #   vim.opt.isfname:append("@-@")
              #
              #   vim.opt.updatetime = 50
              #
              #   vim.g.mapleader = " "
              #
              #   require("catppuccin").setup({
              #       flavour = "frappe",
              #   })
              #   vim.cmd.colorscheme("catppuccin")
              #
              #   local telescope = require("telescope").setup({})
              #   local telescope_builtin = require("telescope.builtin")
              #   vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
              #   vim.keymap.set("n", "<leader>fg", telescope_builtin.git_files, {})
              #   vim.keymap.set("n", "<leader>fs", function()
              #       telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
              #   end)
              #
              #   require("nvim-treesitter.configs").setup({
              #       ensure_installed = {},
              #       sync_install = false,
              #       auto_install = false,
              #       highlight = {
              #           enable = true,
              #           additional_vim_regex_highlighting = false,
              #       },
              #       indent = { enable = true },
              #       incremental_selection = {
              #           enable = true,
              #       },
              #   })
              #
              #   local null_ls = require("null-ls")
              #   null_ls.setup({
              #       sources = {
              #           null_ls.builtins.formatting.stylua,
              #           null_ls.builtins.formatting.nixfmt,
              #       },
              #   })
              #   vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
              #
              #   vim.lsp.enable("lua_ls")
              #   vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
              #   vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
              #   vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
              #
              #   local cmp = require("cmp")
              #
              #   cmp.setup({
              #       snippet = {
              #           -- REQUIRED - you must specify a snippet engine
              #           expand = function(args)
              #               -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
              #               require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
              #               -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
              #               -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              #               -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
              #
              #               -- For `mini.snippets` users:
              #               -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
              #               -- insert({ body = args.body }) -- Insert at cursor
              #               -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
              #               -- require("cmp.config").set_onetime({ sources = {} })
              #           end,
              #       },
              #       window = {
              #           completion = cmp.config.window.bordered(),
              #           documentation = cmp.config.window.bordered(),
              #       },
              #       mapping = cmp.mapping.preset.insert({
              #           ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              #           ["<C-f>"] = cmp.mapping.scroll_docs(4),
              #           ["<C-Space>"] = cmp.mapping.complete(),
              #           ["<C-e>"] = cmp.mapping.abort(),
              #           ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
              #       }),
              #       sources = cmp.config.sources({
              #           -- { name = 'nvim_lsp' },
              #           -- { name = 'vsnip' }, -- For vsnip users.
              #           { name = "luasnip" }, -- For luasnip users.
              #           -- { name = 'ultisnips' }, -- For ultisnips users.
              #           -- { name = 'snippy' }, -- For snippy users.
              #       }, {
              #           { name = "buffer" },
              #       }),
              #   })
              # '';
              # programs.neovim.plugins = [
              #   {
              #       plugin = pkgs.vimPlugins.catppuccin-nvim;
              # type = "lua";
              #       config = ''
              #           require("catppuccin").setup({
              #               flavour = "frappe",
              #           })
              #           vim.cmd.colorscheme("catppuccin")
              #       '';
              #   }
              # ];
              #         programs.neovim.plugins = [
              #           {
              #               plugin = pkgs.vimPlugins.catppuccin-nvim;
              # type = "lua";
              #               config = ''
              #     vim.cmd([[
              #       packadd catppuccin-nvim
              #     ]])
              #     -- packadd! catppuccin-nvim
              #     require("catppuccin-nvim")
              #
              #     --lua << END
              #     --	require 'catppuccin-nvim'.setup {
              #
              # --	}
              #     --END
              #                   vim.opt.colorscheme = "catppuccin"
              #               '';
              #           }
              #         ];
              # programs.nixvim.enable = true;
              # programs.nixvim.colorschemes.catppuccin.enable = true;
              # programs.nixvim.colorschemes.catppuccin.package = pkgs.vimPlugins.catppuccin-nvim;
              #    xdg.configFile."nvim/plugin/catppuccin".enable = true;
              #    xdg.configFile."nvim/plugin/catppuccin".source = "${pkgs.vimPlugins.catppuccin-nvim}/lua/catppuccin";
              #    xdg.configFile."nvim/init.lua".enable = true;
              #    xdg.configFile."nvim/init.lua".text = ''
              # vim.opt.number = true
              # vim.opt.relativenumber = true
              #
              # vim.opt.tabstop = 4
              # vim.opt.softtabstop = 4
              # vim.opt.shiftwidth = 4
              # vim.opt.expandtab = true
              #
              # vim.opt.smartindent = true
              #
              # vim.opt.wrap = false
              #
              # vim.opt.swapfile = false
              # vim.opt.backup = false
              # vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
              # vim.opt.undofile = true
              #
              # vim.opt.hlsearch = false
              # vim.opt.incsearch = true
              #
              # vim.opt.termguicolors = true
              #
              # vim.opt.scrolloff = 8
              # vim.opt.signcolumn = "yes"
              # vim.opt.isfname:append("@-@")
              #
              # vim.opt.updatetime = 50
              #
              #             local catppuccin = require("plugin/catppuccin/init.lua")
              #             -- local catppuccin = dofile("${pkgs.vimPlugins.catppuccin-nvim}/lua/catppuccin/init.lua")
              #             catppuccin.setup()
              #    '';

              # man
              programs.man.enable = true;
              programs.man.generateCaches = false;

              # bash
              programs.bash.enable = true;
              programs.bash.enableCompletion = true;
              programs.bash.bashrcExtra =
                "	source ${pkgs.blesh}/share/blesh/ble.sh\n";

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

              # posh
              programs.oh-my-posh.enable = true;
              programs.oh-my-posh.enableZshIntegration = false;
              programs.oh-my-posh.enableBashIntegration = true;
              programs.oh-my-posh.useTheme = "catppuccin";

              # zen browser
              xdg.mimeApps.associations.added."x-scheme-handler/http" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/https" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/chrome" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."text/html" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-htm" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-html" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-shtml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/xhtml+xml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-xhtml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.associations.added."application/x-extension-xht" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."default-web-browser" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/http" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/https" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."x-scheme-handler/chrome" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."text/html" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-htm" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-html" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-shtml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/xhtml+xml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-xhtml" =
                [ "zen-beta.desktop" ];
              xdg.mimeApps.defaultApplications."application/x-extension-xht" =
                [ "zen-beta.desktop" ];

              # firefox
              programs.firefox.enable = true;
              programs.firefox.profiles.default.extensions.packages =
                with pkgs.nur.repos.rycee.firefox-addons;
                [
                  ublock-origin
                  # gnome-shell-integration
                ];
              programs.firefox.profiles.default.settings = {
                "extensions.autoDisableScopes" = 0;
              };

              # gnome
              xdg.mimeApps.associations.added."text/plain" =
                [ "org.gnome.TextEditor.desktop" ];
              xdg.mimeApps.defaultApplications."text/plain" =
                [ "org.gnome.TextEditor.desktop" ];

              dconf.enable = true;
              dconf.settings."org/gnome/settings-daemon/plugins/media-keys".custom-keybindings =
                [
                  "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" # flameshot
                ];
              dconf.settings."org/gnome/desktop/interface".color-scheme =
                "prefer-dark";
              dconf.settings."org/gnome/desktop/session".idle-delay =
                mkUint32 0;
              dconf.settings."org/gnome/shell".disable-user-extensions = false;
              dconf.settings."org/gnome/shell".enabled-extensions =
                with pkgs.gnomeExtensions; [
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
              xdg.mimeApps.associations.added."x-scheme-handler/tg" =
                [ "org.telegram.desktop.desktop" ];
              xdg.mimeApps.associations.added."x-scheme-handler/tonsite" =
                [ "org.telegram.desktop.desktop" ];

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
              programs.zed-editor.extensions = [ "nix" "toml" "elixir" "make" ];
              programs.zed-editor.userSettings.assistant.enable = false;
              programs.zed-editor.userSettings.lsp.rust-analyzer.binary.path_lookup =
                true;
              programs.zed-editor.userSettings.lsp.nix.binary.path_lookup =
                true;
              programs.zed-editor.userSettings.vim_mode = false;
              programs.zed-editor.userSettings.format_on_save = "on";
              programs.zed-editor.userSettings.theme.mode = "system";
              programs.zed-editor.userSettings.theme.light = "One Light";
              programs.zed-editor.userSettings.theme.dark = "One Dark";

              # obs
              programs.obs-studio.enable = true;
              programs.obs-studio.package =
                (pkgs.obs-studio.override { cudaSupport = true; });
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
              programs.git.userEmail =
                "146812294+hey-adora@users.noreply.github.com";
              programs.git.extraConfig.safe.directory = "*";

              # mpv
              programs.mpv.enable = true;
              programs.mpv.config.hwdec = "auto";
              programs.mpv.config.screenshot-format = "png";
              programs.mpv.config.screenshot-directory = "/mnt/hdd2/pictures/";

              # atuin
              programs.atuin.enable = true;
              programs.atuin.daemon.enable = true;
              programs.atuin.enableBashIntegration = true;
              programs.atuin.enableZshIntegration = true;

              # vscode
              programs.vscode.enable = true;
              programs.vscode.package = pkgs.vscodium;
              programs.vscode.profiles.default.userSettings."editor.formatOnSave" =
                true;
              programs.vscode.profiles.default.userSettings."rust-analyzer.check.command" =
                "clippy";
              programs.vscode.profiles.default.extensions =
                with pkgs.vscode-extensions; [
                  jnoortheen.nix-ide
                  vscodevim.vim
                  rust-lang.rust-analyzer
                  tamasfe.even-better-toml
                  fill-labs.dependi
                  llvm-vs-code-extensions.vscode-clangd
                  # ms-dotnettools.csdevkit
                  bradlc.vscode-tailwindcss
                  svelte.svelte-vscode
                  esbenp.prettier-vscode
                  dbaeumer.vscode-eslint
                  vadimcn.vscode-lldb
                  # DioxusLabs.dioxus
                ];
              # ++ with pkgs.vscode-extensions; [

              #   jnoortheen.nix-ide
              #   vscode-extensions.vscodevim.vim
              #   ms-dotnettools.csdevkit
              #   vadimcn.vscode-lldb
              # ];

            }

          )
        ];
      };
    };
}
