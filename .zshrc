#PATH
export PATH="$HOME/.local/bin:$PATH"
#Plugins
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/plugins/git/git-prompt.sh
source ~/.zsh/plugins/zsh-z/zsh-z.plugin.zsh
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Set up the prompt
setopt PROMPT_SUBST
NL=$'\n'
PS1='$NL%B%F{blue}%B%n%f %F{cyan}%3~%f%b% %F{magenta}$(__git_ps1 "  %s")%f$NL%B%(?.%F{green}.%F{red})%(!.#.>)%f%b '

#zsh-z plugin options
ZSH_CASE=smart
#Fuck
eval $(thefuck --alias)

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
# Enable forward word movement with Ctrl+Right Arrow
bindkey '^[[1;5C' forward-word
# Enable backward word movement with Ctrl+Left Arrow
bindkey '^[[1;5D' backward-word
# Enable backward word deletion with Ctrl+Backspace
bindkey '^H' backward-kill-word

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# No beeping noise
setopt NO_BEEP

# Auto Completion
autoload -Uz compinit && compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=1
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#Allows for Dot file git sync
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

#some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'




alias vim=nvim
