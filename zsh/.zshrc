# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Warden: Nice fallback w/o powerline: ZSH_THEME="dieter"
# Warden: Nice theme with powerline but no time: ZSH_THEME="agnoster"
ZSH_THEME="bullet-train"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(virtualenv z common-aliases gpg-agent history-substring-search zsh-completions)

# Completions from zsh-completions plugin
autoload -U compinit && compinit

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Make less more powerful (https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/)
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# GOPATH
export GOPATH=$HOME/src/golang

# Default to homebrew ruby
export PATH=/usr/local/opt/ruby/libexec/gembin:/usr/local/opt/ruby/bin:$PATH

# Default to homebrew openssl binary
export PATH=/usr/local/opt/openssl/bin:$PATH

# {{{ Vim-like hjkl line movements and line manipuation
bindkey '^H' beginning-of-line
bindkey '^J' backward-word
bindkey '^K' forward-word
bindkey '^L' end-of-line

# When moving between words you probably want to change the current word...
# iTerm2 needs to be configured to send \E[19;2~ (f20) when ctrl-; is pressed.
bindkey '^[[19;2~' delete-word
# }}}

# {{{ Bullet Train theme settings
BULLETTRAIN_TIME_BG='magenta'
BULLETTRAIN_TIME_FG='white'
BULLETTRAIN_CONTEXT_SHOW='true'
BULLETTRAIN_CONTEXT_BG='green'
BULLETTRAIN_CONTEXT_FG='white'
# }}}
