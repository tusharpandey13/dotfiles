
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
# fi

# # added by Anaconda3 installer
# export PATH="/home/tushar/anaconda3/bin:$PATH"


# virtualenv and virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh
#
#
# Enable blur in Yakuake
#if [[ $(ps --no-header -p $PPID -o comm) =~ xfce4-terminal ]]; then
#    for wid in $(xdotool search --pid $PPID); do
#        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
#fi


#. /home/tushar/tmp/torch/install/bin/torch-activate
#
#
#
#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

export LIBVA_DRIVER_NAME=iHD
export VDPAU_DRIVER=va_gl


PATH="${PATH:+${PATH}:}$HOME/.cargo/bin"
PATH="${PATH:+${PATH}:}/home/tushar/Android/Sdk"
PATH="${PATH:+${PATH}:}/usr/lib/jvm/java-10-openjdk/bin"

#export JAVA_HOME=/usr/lib/jvm/java-10-openjdk/bin

# export ANDROID_HOME="/home/tushar/Android/Sdk"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/home/tushar/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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



export GDK_DPI_SCALE=1.25

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
