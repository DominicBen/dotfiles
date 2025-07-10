# ==========================================
# TMUX support
# ==========================================
# If ssh detected attach to existing tmux session or create new one
# if command -v tmux &>/dev/null; then
#   test -z "$TMUX" && exec tmux
# fi
check_git_updates() {
  local repos=(~/Repos ~/.dotfiles)

  echo "🔍 Checking Git repositories for updates..."

  for base in "${repos[@]}"; do
    if [[ -d "$base/.git" ]]; then
      dirs=("$base")
    else
      dirs=("$base"/*)
    fi

    for dir in "${dirs[@]}"; do
      [[ -d "$dir/.git" ]] || continue
      cd "$dir" || continue

      git fetch --quiet

      local local_ref=$(git rev-parse @)
      local remote_ref=$(git rev-parse @{u} 2>/dev/null)
      local base_ref=$(git merge-base @ @{u} 2>/dev/null)

      if [[ "$local_ref" == "$remote_ref" ]]; then
        continue
      elif [[ "$local_ref" == "$base_ref" ]]; then
        echo "🔄 $(basename "$dir") has updates to pull"
      elif [[ "$remote_ref" == "$base_ref" ]]; then
        echo "🔼 $(basename "$dir") has commits to push"
      else
        echo "⚠️  $(basename "$dir") has diverged"
      fi
    done
  done
}

# Run it when a new shell session starts (optional: guard to avoid slowdown on login)


# ==========================================
# PATH Configuration
# ==========================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/mnt/c/Users/DMAN/.wsl-tools"
export PIP_BREAK_SYSTEM_PACKAGES=1
export EDITOR=nvim

# ==========================================
# Plugin Sourcing
# ==========================================
# Source Zsh Plugins
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/git/git-prompt.sh
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-autoswitch-virtualenv/autoswitch_virtualenv.plugin.zsh
source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# ==========================================
# Prompt Configuration
# ==========================================
conda_prompt() {
    if [ -n "$CONDA_DEFAULT_ENV" ]; then
        echo "(${CONDA_DEFAULT_ENV})"
    fi
}
setopt PROMPT_SUBST

NL=$'\n'
PS1='$NL%B%F{blue}%B%n%f %F{cyan}%3~%f%b% %F{magenta}$(__git_ps1 "  %s")%f$NL%B%(?.%F{green}.%F{red})%(!.#.>)%f%b '

# ==========================================
# Plugin Options
# ==========================================
# zsh-z Plugin Options
ZSH_CASE=smart

# ==========================================
# Shell Options
# ==========================================
# History Configuration
setopt histignorealldups
setopt sharehistory
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Disable Beeping Noise
setopt NO_BEEP

# ==========================================
# Key Bindings
# ==========================================
# Use Emacs Keybindings
bindkey -e
# Enable Forward Word Movement with Ctrl+Right Arrow
bindkey '^[[1;5C' forward-word
# Enable Backward Word Movement with Ctrl+Left Arrow
bindkey '^[[1;5D' backward-word
# Enable Backward Word Deletion with Ctrl+Backspace
bindkey '^H' backward-kill-word
# Make Complete Suggestion Shift+Tab
bindkey '^[[Z' autosuggest-accept
# ==========================================
# Aliases
# ==========================================
# Git Configuration Alias
#alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# LS Aliases
#

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#ShellGPT
alias ask='sgpt'
#fast node manager
alias nvm='fnm'
# Python and Vim Aliases
alias python='python3'
alias vim='nvim'
alias nv='nvim'
# Top alias
alias htop='btop'
#lazy git
alias lg='lazygit'
alias update='sudo apt upgrade -y && sudo apt update -y'
alias neofetch='fastfetch'
alias fetch='fastfetch'
extract() {
  if [[ -f "$1" ]]; then
    # Remove common archive extensions to get folder name
    local folder="${1%.*}"
    folder="${folder%.tar}"  # Handles .tar.gz or .tar.xz

    mkdir -p "$folder"  # Create target folder if it doesn't exist

    case "$1" in
      *.tar) tar -xf "$1" -C "$folder" ;;
      *.tar.gz|*.tgz) tar -xzf "$1" -C "$folder" ;;
      *.tar.xz|*.txz) tar -xJf "$1" -C "$folder" ;;
      *.zip) unzip -d "$folder" "$1" ;;
      *) echo "Unsupported file type: $1" ;;
    esac
  else
    echo "File not found: $1"
  fi
}

alias matrix='cmatrix'
alias clock='tty-clock'
# ==========================================
# Conda Initialization
# ==========================================

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/golgi/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/golgi/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/golgi/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/golgi/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ==========================================
# FNM (Fast Node Manager) Initialization
# ==========================================
FNM_PATH="/home/golgi/.fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/golgi/.fnm:$PATH"
  eval "`fnm env`"
fi

# ==========================================
# Auto-Completion Optimization
# ==========================================
# Create Cache Directory if it doesn't exist
mkdir -p ~/.zsh/cache

# Load and Initialize `compinit` with Caching
autoload -Uz compinit
compinit -C -d ~/.zcompdump

# Configure Completion Styles for Performance
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Avoid Running `compaudit` on Each Startup
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

# ==========================================
# Aliases and Functions (Optional Optimizations)
# ==========================================
# Consider Lazy-Loading Plugins or Functions Here
# Example:
# function load_my_plugin() {
#     source ~/.zsh/plugins/my-plugin/my-plugin.zsh
# }
# alias enable-my-plugin='load_my_plugin'

# ==========================================
# End of Configuration
# ==========================================

# ==========================================
# Optional: Precompile `.zshrc` for Faster Loading
# ==========================================
# Uncomment the following line to precompile your `.zshrc`
#
# zcompile ~/.zshrc
fetch

# fnm
FNM_PATH="/home/golgi/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/golgi/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
