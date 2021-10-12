# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# WSL defaults to 0000, so be explicit
umask 0022

# Disable Magic Plugins to make pasting text faster, see
DISABLE_MAGIC_FUNCTIONS=true

# Exclude Windows Ruby from PATH
# ":# is a substitution that filters out the input that matches the pattern"
path=( ${path[@]:#*/mnt/c/tools/ruby27/bin*} )

# Look for Puppet executables and man pages
export PATH="/opt/puppetlabs/bin:$PATH"
export MANPATH="/opt/puppetlabs/client-tools/share/man:$MANPATH"

# Make less more powerful (https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/)
export LESS='--ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# XDG configs
export XDG_CONFIG_HOME="${HOME}/.config"

# Tmux use XDG config location
alias tmux='tmux -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"'

# Load Antigen if on modern Zsh (>= 5.1)
autoload is-at-least
if is-at-least 5.1; then
    source ~/.zsh/antigen.zsh

    antigen bundle z
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions

    antigen theme romkatv/powerlevel10k

    antigen apply

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
