{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "soyccan";
  home.homeDirectory = "/home/soyccan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # shell utils
    bat
    bottom
    delta
    dog
    # dust
    eza
    fd
    fzf
    glow
    htop
    httpie
    hyperfine
    jq
    just
    lsd
    most
    neofetch
    nushell
    p7zip
    procs
    pyenv
    ripgrep
    sd
    starship
    tealdeer
    tmux
    tokei
    unzip
    xz
    yadm
    zellij
    zip
    zoxide

    # develop
    # bear
    # foundryup
    # ghcup
    git
    # TODO: diff-highlight from git pkg
    helix
    lazygit
    ninja
    pre-commit
    rustup
    tig
    tree-sitter

    # system tools
    sysstat  # iostat & mpstat

    # networking tools
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    bandwhich # Terminal bandwidth utilization tool
    dnsutils  # `dig` + `nslookup`
    ethtool
    ipcalc  # it is a calculator for the IPv4/v6 addresses
    iperf3
    ldns # replacement of `dig`, it provide the command `drill`
    mtr # A network diagnostic tool
    nmap # A utility for network discovery and security auditing
    socat # replacement of openbsd-netcat

    # productivity
    hugo # static site generator

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/soyccan/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Disable man pages to avoid conflicting with system man pages
  # otherwise, man is installed by home manager and shadows the system man, making apropos
  # fail to lookup man pages:
  # [manpages of host OS are not visible for me · Issue #432 · nix-community/home-manager](https://github.com/nix-community/home-manager/issues/432)
  programs.man.enable = false;
}
