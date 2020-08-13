# WSL defaults to 0000, so be explicit
umask 0022

# WSL2 X11
export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

# Exclude Windows Ruby from PATH
# ":# is a substitution that filters out the input that matches the pattern"
path=( ${path[@]:#*/mnt/c/tools/ruby27/bin*} )

# Look for Puppet executables and man pages
export PATH="/opt/puppetlabs/bin:$PATH"
export MANPATH="/opt/puppetlabs/client-tools/share/man:$MANPATH"

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
# Disable NodeJS section
BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  screen
  perl
  ruby
  virtualenv
  aws
  go
  rust
  elixir
  git
  hg
  cmd_exec_time
)


# Tmux use XDG config location
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'

# Load Antigen (https://github.com/zsh-users/antigen)
source ~/.zsh/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from oh-my-zsh
antigen bundle z

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply
