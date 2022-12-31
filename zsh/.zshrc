setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
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


# ========================== DEFAULT END HERE ==========================

# Use neovim as the default terminal
export EDITOR=/usr/bin/nvim

# Virtual environments
export PATH="$HOME/.local/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# go
export PATH="$HOME/go/bin:$PATH"

# nodenv
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"
export GOPATH="$HOME/go"


# ZSH shell options and settings
unsetopt BEEP  # Disable beeping in zsh instead of globally in terminal

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line
bindkey "$key[Up]" up-line-or-search
bindkey "$key[Down]" down-line-or-search

# Color support for ls and some other commands (use .dircolors)
if [ -x /usr/bin/dircolors ]; then
    test -r $ZDOTDIR/dircolors && eval "$(dircolors -b $ZDOTDIR/dircolors)" || eval "$(dircolors -b)"
fi

# Syntax highlighting (github.com/zsh-users/zsh-syntax-highlighting)
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Quickly jump around
setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
alias d='dirs -v'
for index ({0..9}) alias "d$index"="cd +${index}"; unset index

# Enable autojump (github.com/agkozak/zsh-z)
source $ZDOTDIR/plugins/zsh-z/zsh-z.plugin.zsh
unalias z
function z() { zshz 2>&1 "$@" }

# Useful shell functions
source $ZDOTDIR/functions.zsh

# Alias definitions
source $ZDOTDIR/plugins/zsh-expand-all/zsh-expand-all.zsh
source $ZDOTDIR/aliases.zsh

# Show git alias expansions
function git() {
    # GIT_TRACE=1 /bin/git "$@" 2> >(awk '!/trace/{x++} {if(NR==3){sub(/.+\s\s\S+\s/,"");print}else if(x>0){print}}' >&2)
    # GIT_TRACE=1 /bin/git "$@" 2> >(awk '/^[0-9:.]{15}/{if(NR==3 && $0 ~ /(run_command: \W|alias expansion)/){sub(/.+\s\s\S+\s/,"");print;};next;}{print;}' >&2)
    GIT_TRACE=1 /bin/git "$@" 2> >(awk '/^[0-9:.]{15}/{if(NR==3 && $0 ~ /alias expansion/){sub(/.+\s\s\S+\s/,"");print;};next;}{print;}' >&2)
}

# My customised prompt
source $ZDOTDIR/zshprompt.zsh
