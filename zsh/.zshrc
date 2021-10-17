# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# WSL defaults to 0000, so be explicit
umask 0022

# Disable Magic Plugins in oh-my-zsh to make pasting text faster
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

# Zsh History, mostly stolen from oh-my-zsh
export HISTSIZE=50000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# fzf if available
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# ssh-agent for non-Apple
if [[ "OSTYPE" != darwin* ]]; then
    export SSH_AUTH_SOCK="${HOME}/.ssh/.ssh-agent.sock"
    SSH_AGENT_PID=$(command pgrep -u $UID ssh-agent)
    if [[ "" = $SSH_AGENT_PID ]]; then
        eval $(ssh-agent -a $SSH_AUTH_SOCK) >/dev/null
    else
        export SSH_AGENT_PID
    fi
fi

# Load Antigen if on modern Zsh (>= 5.1)
autoload is-at-least
if is-at-least 5.1; then
    source ~/.zsh/antigen.zsh

    antigen use oh-my-zsh

    antigen bundle z
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions

    antigen theme romkatv/powerlevel10k

    antigen apply

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
    bindkey -e
fi

# LSDeluxe, if available. Has to come after omz is loaded.
if [[ $(type lsd) ]]; then
    alias ls='lsd'
    alias lt='lsd --tree --depth=2'
fi
