{ config, pkgs, user, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles";
in

{
  home.username = user;
  home.homeDirectory = "/Users/bytedance";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    # cli i use constantly
    ripgrep   # fast search
    fd        # fast find
    fzf       # fuzzy finder
    glow      # markdown viewer
    jq        # json on the command line
    lazygit
    neovim
  ];
  fonts.fontconfig.enable = true;
  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/go/bin"
    "${config.home.homeDirectory}/flutter/bin"
    "${config.home.homeDirectory}/.pub-cache/bin"
    "${config.home.homeDirectory}/.larklink/bin"
    "${config.home.homeDirectory}/.bun/bin"
    "/usr/local/go/bin"
    "/opt/homebrew/bin"
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "${config.home.homeDirectory}/go";
    GOROOT = "/usr/local/go";
    BUN_INSTALL = "${config.home.homeDirectory}/.bun";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;      # ghost text from history
    syntaxHighlighting.enable = true;  # commands turn green when valid
    initContent = ''
      git_current_branch() {
        command git symbolic-ref --quiet --short HEAD 2>/dev/null ||
          command git rev-parse --short HEAD 2>/dev/null
      }

      git_main_branch() {
        command git rev-parse --git-dir >/dev/null 2>&1 || return
        local branch
        for branch in main trunk mainline default stable master; do
          command git show-ref -q --verify "refs/heads/$branch" && { echo "$branch"; return 0; }
          command git show-ref -q --verify "refs/remotes/origin/$branch" && { echo "$branch"; return 0; }
          command git show-ref -q --verify "refs/remotes/upstream/$branch" && { echo "$branch"; return 0; }
        done
        echo master
        return 1
      }

      git_develop_branch() {
        command git rev-parse --git-dir >/dev/null 2>&1 || return
        local branch
        for branch in dev devel develop development; do
          command git show-ref -q --verify "refs/heads/$branch" && { echo "$branch"; return 0; }
        done
        echo develop
        return 1
      }

      bindkey '^f' autosuggest-accept
    '';
    shellAliases = {
      ".." = "cd ..";
      add = "git add .";
      push = "git push";
      pull = "git pull";
      m = "git switch main";
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gapa = "git add --patch";
      gau = "git add --update";
      gb = "git branch";
      gba = "git branch --all";
      gbd = "git branch --delete";
      "gbD" = "git branch --delete --force";
      gbm = "git branch --move";
      gbr = "git branch --remote";
      gco = "git checkout";
      gcb = "git checkout -b";
      "gcB" = "git checkout -B";
      gcd = "git checkout $(git_develop_branch)";
      gcm = "git checkout $(git_main_branch)";
      gcp = "git cherry-pick";
      gcpa = "git cherry-pick --abort";
      gcpc = "git cherry-pick --continue";
      gcl = "git clone --recurse-submodules";
      gc = "git commit --verbose";
      gca = "git commit --verbose --all";
      "gca!" = "git commit --verbose --all --amend";
      "gcan!" = "git commit --verbose --all --no-edit --amend";
      "gc!" = "git commit --verbose --amend";
      gcmsg = "git commit --message";
      gd = "git diff";
      gdca = "git diff --cached";
      gdcw = "git diff --cached --word-diff";
      gds = "git diff --staged";
      gdw = "git diff --word-diff";
      gf = "git fetch";
      gfa = "git fetch --all --tags --prune --jobs=10";
      gfo = "git fetch origin";
      gl = "git pull";
      gpr = "git pull --rebase";
      gpra = "git pull --rebase --autostash";
      gprom = "git pull --rebase origin $(git_main_branch)";
      gp = "git push";
      gpd = "git push --dry-run";
      gpf = "git push --force-with-lease";
      "gpf!" = "git push --force";
      gpsup = "git push --set-upstream origin $(git_current_branch)";
      gpv = "git push --verbose";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      grbi = "git rebase --interactive";
      grbs = "git rebase --skip";
      grbm = "git rebase $(git_main_branch)";
      grbom = "git rebase origin/$(git_main_branch)";
      gr = "git remote";
      grv = "git remote --verbose";
      grh = "git reset";
      gru = "git reset --";
      grhh = "git reset --hard";
      grs = "git restore";
      grst = "git restore --staged";
      grev = "git revert";
      grm = "git rm";
      grmc = "git rm --cached";
      gsh = "git show";
      gstall = "git stash --all";
      gsta = "git stash push";
      gstaa = "git stash apply";
      gstc = "git stash clear";
      gstd = "git stash drop";
      gstl = "git stash list";
      gstp = "git stash pop";
      gsts = "git stash show --patch";
      gst = "git status";
      gss = "git status --short";
      gsb = "git status --short --branch";
      gsw = "git switch";
      gswc = "git switch --create";
      gswd = "git switch $(git_develop_branch)";
      gswm = "git switch $(git_main_branch)";
      glo = "git log --oneline --decorate";
      glog = "git log --oneline --decorate --graph";
      gloga = "git log --oneline --decorate --graph --all";
      glg = "git log --stat";
      gwt = "git worktree";
      gwta = "git worktree add";
      gwtls = "git worktree list";
      gwtrm = "git worktree remove";
      cc = "claude";
      co = "codex";
      ppi = "/Users/bytedance/.pi/agent/pi-with-proxy.sh";
      firstmate = "cd /Users/bytedance/Documents/agentic-tools/firstmate";
      killer_harness = "cd /Users/bytedance/Documents/agentic-tools/killer_harness";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
      };
      cmd_duration.format = "[$duration]($style) ";
    };
  };

  # Edit-in-place: the real file stays in my repo, ~/.config just points at it.
  home.file.".config/wezterm".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/wezterm";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/nvim";
  home.file.".config/herdr".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/herdr";
  home.file."Library/Preferences/glow/glow.yml".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/Library/Preferences/glow/glow.yml";
  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/user.workflow.codex.app-switcher/info.plist".source =
    config.lib.file.mkOutOfStoreSymlink "${dotfiles}/home/.config/alfred/workflows/user.workflow.codex.app-switcher/info.plist";
  home.file.".local/share/fonts/hack-nerd-font".source =
    "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack";
}
