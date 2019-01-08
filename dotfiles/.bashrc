# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# In Fedora: sudo dnf install vim-X11
exists()
{
    command -v "$1" >/dev/null 2>&1
}
if exists vimx; then
    alias vi='vimx'
    alias vim='vimx'
    export SUDO_EDITOR=/usr/bin/vimx
else
    export SUDO_EDITOR=/usr/bin/vim
fi
if [ -f /usr/bin/powerline-daemon ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi


# tmux ressurect history - don't write history -r into the pane
HISTCONTROL=ignoreboth


# aws ecr
ecr() {
    # Usage: ecr <company-name>
    # Example: ecr <idevelop-city>
    _aws_profile=${1:-default}
    eval "$(aws --profile $_aws_profile ecr get-login --no-include-email)"
}

battery() {
    file=~/.battery/$1
    if [ -f $file ] ; then
        sh $file $2 $3
    else
        echo "Example of usage:
              battery remaining,
              battery status,
              battery setup <start_charge_percent> <stop_charge_percent>"
    fi
}
export PATH="/home/f0t0n/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -s "/home/f0t0n/.gvm/scripts/gvm" ]] && source "/home/f0t0n/.gvm/scripts/gvm"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
