# WSL defaults to 0000, so be explicit
umask 0022

# Make less more powerful (https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/)
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# XDG configs
export XDG_CONFIG_HOME="${HOME}/.config"

# Bullet Train theme settings
BULLETTRAIN_TIME_BG='magenta'
BULLETTRAIN_TIME_FG='white'
BULLETTRAIN_CONTEXT_BG='magenta'
BULLETTRAIN_CONTEXT_FG='white'
BULLETTRAIN_CONTEXT_DEFAULT_USER='warden'
BULLETTRAIN_EXEC_TIME_ELAPSED='2'

# Tmux use XDG config location
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'

# Load Antigen (https://github.com/zsh-users/antigen)
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from oh-my-zsh
antigen bundle z
antigen bundle ssh-agent

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply
