
 alias zshconfig="vim ~/.zsh_aliases.sh && source ~/.zshrc"
 alias pm="yay -S"
 alias reloadzsh="source ~/.zshrc"
 alias cleanpacman="sudo ~/cleanpacman.sh"
 alias sctl="sudo systemctl"
 alias addkey="gpg --recv-key"
 alias py="python3"
 alias tn="ping 8.8.8.8"
 alias cp="rsync --progress -ravze ssh" 
 alias ..="cd .."
 alias top="htop"
 alias x+="chmod +x"
 alias cls="clear"
 alias suspend="sudo systemctl suspend"
 alias pip3="sudo python3 -m pip"
 alias condapip="sudo ~/anaconda3/bin/pip"
 alias 757="sudo chmod -R 757"
 alias q="exit"
 alias pyc="ipython"
 alias pmn='sudo pacman' 
 alias mountwin='sudo mount /dev/sda3 /run/media/tushar/OS && sudo mount /dev/sda8 /run/media/tushar/DATA'
 alias umountwin='sudo umount /dev/sda3 && sudo umount /dev/sda8'
#alias gcln='git clone'
alias code='/usr/bin/code-oss --force-device-scale-factor=1 --ignore-gpu-blocklist --enable-gpu-rasterization --enable-oop-rasterization --unity-launch --no-sandbox -n .'
 alias seed='~/seed.py'
 alias pullhead='git pull origin $(git rev-parse --abbrev-ref HEAD)'
#alias gitu='gitbackup'
 alias ls="ls_extended --group-directories-first"
 alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
 alias npmi="sudo npm i"
 alias img="gpicview"
 alias -g clip="xclip -sel clip"
 alias gitc="git checkout"
# alias portsl="sudo lsof -i -P -n | grep LISTEN"
 alias rmrf="rm -Rf"
 alias sql="mysql -s -t --prompt='sql >  '" 
 alias logout="qdbus org.kde.ksmserver /KSMServer logout 0 3 3"
 alias performance="sudo cpupower frequency-set -g performance"
 alias powersave="sudo cpupower frequency-set -g powersave"
 alias rem="notify-send"
 alias downloadsubs="py /home/tushar/download_en_subs.py -d"
 alias backup_dotfiles="sh /home/tushar/backup_dotfiles.sh"


# FUNCTIONS

function ad() {
	aria2c -c --max-connection-per-server=16 --split=16 --min-split-size=1M --human-readable=true "${1}";
	rem "$(basename "${1}") download complete";
}

function remat() {
	echo "notify-send "${0}"" | at ${1};
}

function cd() {
  if [ "$#" = "0" ]
  then
  pushd ${HOME} > /dev/null
  elif [ -f "${1}" ]
  then
    ${EDITOR} ${1}
  else
  pushd "$1" > /dev/null
  fi
}

function bd(){
  if [ "$#" = "0" ]
  then
    popd > /dev/null
  else
    for i in $(seq ${1})
    do
      popd > /dev/null
    done
  fi
}

function coliru {
	g++ -o $1 "$1.cpp" && ./"$1";
}

function b64decode {
	echo $1 | base64 --decode;
}

function adurllist {
	aria2c -c --dir=./ --input-file=$1 --max-concurrent-downloads=1 --connect-timeout=60 --max-connection-per-server=16 --split=16 --min-split-size=1M --human-readable=true --download-result=full --file-allocation=none
}

function webcamrecord240 {
	ffmpeg -f v4l2 -framerate 30 -video_size 426x240 -i /dev/video0 $1;
}

function webcamrecord360 {
    ffmpeg -f v4l2 -framerate 15 -video_size 640x360 -i /dev/video0 $1;
}

function fakewebcam {
	modprobe -n --first-time v4l2loopback;
	sudo ffmpeg -ss 4 -stream_loop -1 -re -i $1 -vf format=yuv420p -f v4l2 /dev/video2;
}

function remat {
	echo "notify-send -t 5000 $1" | at $2 > /dev/null 2>&1;
}

function prepadb {
	sudo adb kill-server;
	sudo adb start-server;
	adb devices;
}

function open {
	xdg-open $1 > /dev/null 2>&1
}

function gitu {
    git rm --cached `git status | grep deleted | sed 's#^.*:##'` &>/dev/null
    git add .

    if [ $# -eq 1 ]
        then
            git commit -m $1
		else
			git commit -m "tushar $(date +"%T")";
    fi
    git push origin $(git rev-parse --abbrev-ref HEAD)
}

function gcln {
    #https://github.com/sigoa/krunner-bridge

	
   tmp="$(/bin/python3 /home/tushar/src/py/gcln.py $1)"
   # IFS=', ' read -r -a array <<< "$tmp"
   # if ["${array[2]}" = "0"]
   # then
   #    echo "${array[0]}"
   #    echo "${array[1]}"
   # else
   #    echo "Wrong URL"
   # fi
   reponame=${tmp##*/}
   reponame=${reponame%.git}
   git clone "$2" "$1" "$reponame";
   cd "$reponame";
}

#function killport {
#	kill $(portsl G $1 | awk '{print $2}') 
#}


function portsl {
	sudo lsof -i:$1;
}

function killport {
	info="$(sudo lsof -i:"$1" -sTCP:LISTEN)";
	pid="$(echo "$info" | awk 'FNR == 2 {print $2}')";
	name="$(echo "$info" | awk 'FNR == 2 {print $1}')";
	if sudo kill -9 $pid > out.log 2> /dev/null; then
		echo "$name, PID $pid killed!"
	else
		echo "No process is LISTENING on port $1"
	fi
}


function pdf2img {
	mkdir "$1-images";
	pdftoppm -jpeg -r 150 $1 "$1-images/pg"
}

function makepdf {
	find . -name "*.png" -exec convert "{}" -background white -alpha remove -alpha off "{}" \;
	img2pdf *.png --output $1
}

function makepdfjpg {
	img2pdf *.jpg --output $1
}

function cdl {
	cd $1
	ls
}

function mcd {
    mkdir -p $1
    cd $1
}

function takeown {
    sudo chgrp -R users $1
    sudo chmod -R g+w $1
}

function startserver {
	port=8000
	if [ $# -eq 1 ]
  		then
    		port=$1
	fi
	echo "Hosting file server for this directory on port :" $port
	#echo "This machine's IP addresses are : (local|local|public)"
	#myip
	echo "Enter http://$(myip):"$port" in your browser's address bar"
	python3 -m http.server $port
}

function gitbackup {
   git rm --cached `git status | grep deleted | sed 's#^.*:##'` &>/dev/null
   git add .
   git commit -m "$(date +"%T")"
	#git push -u $(git rev-parse --abbrev-ref HEAD) 
	git push origin $(git rev-parse --abbrev-ref HEAD)
}


#function pm {
#    sudo apt-get update
#    sudo apt-get $1
#}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
		  tmp="$n"
		  d="${tmp%%.*}";
		  mkdir "$d";
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar|*.bz2) 
                         tar xvf "$n" -C "$d"      ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.rar)       unrar x -ad ./"$n" "$d" ;;
            *.gz)        gunzip -c ./"$n" > "$d"/"$n"    ;;
            *.zip)       unzip ./"$n" -d "$d"      ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n" -o"$d"/       ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}












# Example aliases
# alias du="ncdu"
# alias ohmyzsh="nano ~/.oh-my-zsh"
# alias df='df -h'                                                # Human-readable sizes
 alias free='free -m'                                            # Show sizes in MB
#alias vim="nvim"
# alias tikb="~/toggleinternalkeyboard.sh"
# alias startvnc="~/startvnc.sh"
# alias andkb="~/androidkeyboard.sh"
# alias shtdwn="~/shutdown now"
# alias telegram="flatpak run org.telegram.desktop"
# alias ls="ls_extended"
# alias pm="sudo apt-get"
# alias hotspot="sudo create_ap --config /etc/create_ap.conf"
# alias lxlogout="pkill -SIGTERM -f lxsession"
# alias lmenu="lxsession-logout"
# alias droid="adbfs ~/droid"
 alias mkdir="mkdir -pv"
 alias bc='bc -l'
# handy short cuts #
 alias h='history'
# alias j='jobs -l'
 alias now='date +"%T"'
# alias nowdate='date +"%d-%m-%Y"'
 alias rm='rm -I --preserve-root'
 alias mv='mv -i'
 alias chown='chown --preserve-root'
 alias chmod='chmod --preserve-root'
 alias chgrp='chgrp --preserve-root'
 alias meminfo='free -m -l -t'
 #new ones(global)
   alias -g ...='../..'
   alias -g ....='../../..'
   alias -g .....='../../../..'
#   alias -g CA="2>&1 | cat -A"
   alias -g C='| wc -l'
#   alias -g D="DISPLAY=:0.0"
#   alias -g DN=/dev/null
#   alias -g ED="export DISPLAY=:0.0"
#   alias -g EG='|& egrep'
# alias -g EH='|& head'
#  alias -g EL='|& less'
#  alias -g ELS='|& less -S'
#  alias -g ETL='|& tail -20'
#  alias -g ET='|& tail'
#  alias -g F=' | fmt -'
   alias -g G='| grep'
   alias -g H='| head'
#   alias -g HL='|& head -20'
#   alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
#   alias -g LL="2>&1 | less"
   alias -g L="| less"
   alias -g LS='| less -S'
#  alias -g MM='| most'
   alias -g M='| more'
#   alias -g NE="2> /dev/null"
#  alias -g NS='| sort -n'
#   alias -g NUL="> /dev/null 2>&1"
#  alias -g PIPE='|'
#  alias -g RNS='| sort -nr'
   alias -g S='| sort'
#  alias -g TL='| tail -20'
   alias -g T='| tail'
#  alias -g US='| sort -u'
#  alias -g VM=/var/log/messages
#   alias -g X0G='| xargs -0 egrep'
#   alias -g X0='| xargs -0'
#   alias -g XG='| xargs egrep'
#   alias -g X='| xargs' 
 alias Q='q'








#source /usr/share/doc/pkgfile/command-not-found.zsh



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
#PATH="/home/tushar/.cargo/bin${PATH:+:${PATH}}"; export PATH;
#PATH="/home/tushar/perl5/bin${PATH:+:${PATH}}"; export PATH;
#PERL5LIB="/home/tushar/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="/home/tushar/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"/home/tushar/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/tushar/perl5"; export PERL_MM_OPT;





#$HOME/tmp/hello $USER
#neofetch
#clear

#autoload -Uz promptinit
#promptinit






# prompt_context() {
#  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
#    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
#  fi
# }



export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export EDITOR="vim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISPLAY=":0"

# Blur {{{
if [[ $(ps --no-header -p $PPID -o comm) =~ '^kitty|polybar$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi
# }}}
