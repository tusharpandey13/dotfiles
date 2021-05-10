#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# RVM bash completion
#[[ -r "$HOME/.rvm/scripts/completion" ]] && source "$HOME/.rvm/scripts/completion"

#export PATH=$PATH:~/tmp
#test $USER

# added by Anaconda3 installer
#export PATH="/home/tushar/anaconda3/bin:$PATH"

# added by Anaconda3 installer
#export PATH="/home/tushar/anaconda3/bin:$PATH"

# virtualenv and virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

#export LIBVA_DRIVER_NAME=vdpau
#export VDPAU_DRIVER=nvidia

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/tushar/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/home/tushar/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/home/tushar/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/home/tushar/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<


export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias kt='kitty'
