# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# In Fedora: sudo dnf install vim-X11
alias vi='vimx'
alias vim='vimx'
export SUDO_EDITOR=/usr/bin/vimx
if [ -f /usr/bin/powerline-daemon ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

export PATH="/home/f0t0n/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[[ -s "/home/f0t0n/.gvm/scripts/gvm" ]] && source "/home/f0t0n/.gvm/scripts/gvm"

