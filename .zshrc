# Path to your oh-my-zsh installation.
export ZSH=/home/david/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-nvm zsh-completions zsh-syntax-highlighting)
# plugins=(git zsh-nvm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ####################
# # User configuration
# # ##################
#
# # If you come from bash you might have to change your $PATH.
# # export PATH=$HOME/bin:/usr/local/bin:$PATH
# # export MANPATH="/usr/local/man:$MANPATH"
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8

## Vim mode in ZSH
# bindkey -v

# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char
# bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward

# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select
# export KEYTIMEOUT=1

export TERM=xterm-256color


mount | grep '/home/david/googledrive' >/dev/null || /usr/bin/google-drive-ocamlfuse '/home/david/googledrive'

export PATH="$HOME/.rbenv/bin:/home/david/Android/Sdk/platform-tools:/home/david/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR='vim'
# export DISPLAY=:20

autoload bashcompinit
bashcompinit

zstyle ':completion:*' users root $USER
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)googledrive'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#googledrive'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#googledrive'
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes

# hstr (https://github.com/dvorka/hstr)
export HISTFILE=~/.zsh_history  # ensure history file visibility
# HH_config parameters:
# hicolor    = Get more colors
# rawhistory = Show normal history by default (instead of metrics-based view)
# blacklist  = Skip commands stored in ~/.hh_blacklist when processing history
export HH_CONFIG=hicolor,blacklist
bindkey -s "\C-r" "\eqhh\n"     # bind hh to Ctrl-r (for Vi mode check doc)

export MANPATH="/usr/local/man:$MANPATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias vi=vim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# don't want to exclude hidden files plus ignore googledrive folder and .git
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore-dir googledrive -g ""'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Golang environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

