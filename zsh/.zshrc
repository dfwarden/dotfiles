# WSL defaults to 0000, so be explicit
umask 0022

# Make less more powerful (https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/)
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# Bullet Train theme settings
BULLETTRAIN_TIME_BG='red'
BULLETTRAIN_TIME_FG='white'
BULLETTRAIN_CONTEXT_BG='magenta'
BULLETTRAIN_CONTEXT_FG='white'
BULLETTRAIN_CONTEXT_DEFAULT_USER='warden'
BULLETTRAIN_EXEC_TIME_ELAPSED='2'


# Load Antigen (https://github.com/zsh-users/antigen)
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from oh-my-zsh
antigen bundle z

antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply
