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
# (Apple manages SSH_AUTH_SOCK and launching the agent)
if [[ "${OSTYPE}" == darwin* ]]; then
    # Secretive
    :
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
else
    # if no forwarded agent
    if [[ "" == $SSH_AUTH_SOCK ]]; then
        export SSH_AUTH_SOCK="${HOME}/.ssh/.ssh-agent_${HOSTNAME}_.sock"
        SSH_AGENT_PID=$(command pgrep -u $UID ssh-agent)
        if [[ "" == $SSH_AGENT_PID ]]; then
            rm -f $SSH_AUTH_SOCK
            eval $(ssh-agent -a $SSH_AUTH_SOCK) >/dev/null
        else
            export SSH_AGENT_PID
        fi
    fi
fi

# Load Antigen if on modern Zsh (>= 5.1)
autoload is-at-least
if is-at-least 5.1; then
    source ~/.zsh/antigen.zsh

    antigen bundle z
    antigen bundle zsh-users/zsh-syntax-highlighting
    antigen bundle zsh-users/zsh-completions
    antigen bundle zsh-users/zsh-autosuggestions

    antigen theme romkatv/powerlevel10k

    antigen apply

    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
else
    bindkey -e
fi

# LSDeluxe, if available. Has to come after omz is loaded.
if type lsd &>/dev/null; then
    alias ls='lsd'
    alias lt='lsd --tree --depth=2'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Initialize autocompletions
autoload -Uz compinit
compinit
