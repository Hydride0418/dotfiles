{ pkgs, user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/bytedance";
  };
  system.stateVersion = 6;
  system.defaults = {
    NSGlobalDomain = {
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
      "com.apple.mouse.tapBehavior" = 1;  # tap to click
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = false;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  system.activationScripts.postActivation.text = ''
    # Keep local UI choices that nix-darwin does not fully model as first-class defaults.
    launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- defaults delete -g AppleInterfaceStyle >/dev/null 2>&1 || true
    launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
    killall -qu ${user} cfprefsd || true
    killall -qu ${user} SystemUIServer || true
  '';
  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    inherit user;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";  # first switch: keep existing Homebrew installs
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    brews = [
      "herdr"
    ];
    casks = [
      "wezterm"
      "claude-code"
    ];
  };
}
